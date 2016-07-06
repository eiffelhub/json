note
	description: "JSON deserializer based on reflection mechanism."
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_REFLECTOR_DESERIALIZER

inherit
	JSON_DESERIALIZER
		redefine
			reset
		end

	JSON_TYPE_UTILITIES

feature -- Conversion

	from_json (a_json: detachable JSON_VALUE; ctx: JSON_DESERIALIZER_CONTEXT; a_type: detachable TYPE [detachable ANY]): detachable ANY
		do
			if attached {JSON_STRING} a_json as s then
				Result := string_from_json (s, a_type)
			elseif attached {JSON_OBJECT} a_json as j_object then
				Result := reference_from_json_object (j_object, ctx, a_type)
			elseif attached {JSON_ARRAY} a_json as j_array then
				Result := reference_from_json_array (j_array, ctx, a_type)
			elseif attached {JSON_BOOLEAN} a_json as b then
				Result := boolean_from_json (b)
			elseif attached {JSON_NULL} a_json then
				Result := Void
			elseif attached {JSON_NUMBER} a_json as n then
				Result := number_from_json (n, a_type)
			end
			if ctx.has_error then
				Result := Void
			end
		end

feature -- Cleaning

	reset
			-- <Precursor>
		do
			fields_infos_by_type_id := Void
		end

feature {NONE} -- Helpers		

	reference_from_json_array (a_json: JSON_ARRAY; ctx: JSON_DESERIALIZER_CONTEXT; a_type: detachable TYPE [detachable ANY]): detachable ANY
		local
			l_item_type: detachable TYPE [detachable ANY]
			l_special: detachable SPECIAL [detachable ANY]
			fn: STRING
			i: INTEGER
			obj: detachable ANY
		do
			if a_type = Void then
				ctx.on_value_skipped (a_json, a_type, "Unable to deserialize array without type information!")
			elseif attached ctx.deserializer (a_type) as d and then d /= Current then
				Result := d.from_json (a_json, ctx, a_type)
			elseif a_type.conforms_to ({detachable SPECIAL [detachable ANY]}) then
					-- FIXME: it should be safe to instantiate SPECIAL object here.
				l_special := new_special_any_instance (a_type, a_json.count)
				Result := l_special
				if l_special /= Void and then a_type.generic_parameter_count = 1 then
					l_item_type := a_type.generic_parameter_type (1)
					i := 1
					across
						a_json as ic
					until
						ctx.has_error
					loop
						fn := i.out
						ctx.on_deserialization_field_start (fn)
						obj := ctx.value_from_json (ic.item, l_item_type)
						if obj = Void then
							if l_item_type.is_attached then
								ctx.on_value_skipped (ic.item, l_item_type, "Issue when deserializing array {" + a_type.name + "} at index " + fn)
							else
								l_special.extend (Void)
							end
						elseif attached l_item_type.attempted (obj) as o then
							l_special.extend (o)
						else
							ctx.on_value_skipped (ic.item, l_item_type, "Deserialized Array item {" + obj.generating_type.name + "} mismatch with {" + l_item_type.name + "}")
						end
						ctx.on_deserialization_field_end (fn)
						i := i + 1
					end
				end
			else
				ctx.on_value_skipped (a_json, a_type, "Unable to deserialize array {" + a_type.name + "}!")
--			elseif a_type /= Void then
--				Result := new_instance_of (a_type.type_id)
--				across
--					j_array as ic
--				loop
--				end
			end
			if ctx.has_error then
				Result := Void
			end
		end

	type_name_from_json_object (a_json_object: JSON_OBJECT): detachable READABLE_STRING_32
		do
			if attached {JSON_STRING} a_json_object.item ({JSON_REFLECTOR_SERIALIZER}.type_field_name) as s_type_name then
				Result := s_type_name.item
			end
		end


	reference_from_json_object (a_json_object: JSON_OBJECT; ctx: JSON_DESERIALIZER_CONTEXT; a_type: detachable TYPE [detachable ANY]): detachable ANY
		local
			l_type_name: detachable READABLE_STRING_32
			ref: REFLECTED_REFERENCE_OBJECT
			i: INTEGER
			fn: READABLE_STRING_GENERAL
			l_json_item: detachable JSON_VALUE
			l_field_static_types: like fields_infos
		do
			if Result = Void then
				l_type_name := type_name_from_json_object (a_json_object)
				Result := new_instance_of (l_type_name, a_type)
				if Result = Void then
					if l_type_name /= Void then
						ctx.on_value_skipped (a_json_object, a_type, "Unable to instantiate type %"" + l_type_name + "%".")
					elseif a_type /= Void then
						ctx.on_value_skipped (a_json_object, a_type, "Unable to instantiate type {" + a_type.name + "}")
					else
						ctx.on_value_skipped (a_json_object, a_type, "Unable to instantiate expected object without type information!")
					end
				else
					ctx.on_object (Result, a_json_object)
					create ref.make (Result)
					l_field_static_types := fields_infos (ref)
					across
							-- Follow the order from JSON, in case of reference usage.
						a_json_object as ic
					until
						ctx.has_error
					loop
						fn := ic.key.unescaped_string_32
----							if not fn.starts_with ("$") then
						if attached l_field_static_types.item (fn) as l_field_info then
							i := l_field_info.field_index
							l_json_item := ic.item
							ctx.on_deserialization_field_start (fn)
							inspect
								l_field_info.field_type_id
							when reference_type, expanded_type then
								if attached {JSON_STRING} l_json_item as j_string then
									ref.set_reference_field (i, string_from_json (j_string, l_field_info.static_type))
								else
--										ref.set_reference_field (i, from_json (l_json_item, ctx, l_field_info.static_type))
									ref.set_reference_field (i, ctx.value_from_json (l_json_item, l_field_info.static_type))
								end
							when character_8_type then
								ref.set_character_8_field (i, '%U')
							when character_32_type then
								ref.set_character_32_field (i, '%U')
							when integer_8_type then
								ref.set_integer_8_field (i, integer_from_json (l_json_item).to_integer_8)
							when integer_16_type then
								ref.set_integer_16_field (i, integer_from_json (l_json_item).to_integer_16)
							when integer_32_type then
								ref.set_integer_32_field (i, integer_from_json (l_json_item).to_integer_32)
							when integer_64_type then
								ref.set_integer_64_field (i, integer_from_json (l_json_item))
							when natural_8_type then
								ref.set_natural_8_field (i, natural_from_json (l_json_item).to_natural_8)
							when natural_16_type then
								ref.set_natural_16_field (i, natural_from_json (l_json_item).to_natural_16)
							when natural_32_type then
								ref.set_natural_32_field (i, natural_from_json (l_json_item).to_natural_32)
							when natural_64_type then
								ref.set_natural_64_field (i, natural_from_json (l_json_item))
							when real_32_type then
								ref.set_real_32_field (i, real_from_json (l_json_item).truncated_to_real)
							when real_64_type then
								ref.set_real_64_field (i, real_from_json (l_json_item))
							when pointer_type then
							when boolean_type then
								ref.set_boolean_field (i, boolean_from_json (l_json_item))
							else
							end
							ctx.on_deserialization_field_end (fn)
						end
					end
				end
			end
			if ctx.has_error then
				Result := Void
			end
		end

	boolean_from_json (v: JSON_VALUE): BOOLEAN
		do
			if attached {JSON_BOOLEAN} v as b then
				Result := b.item
			elseif attached {JSON_STRING} v as s then
				Result := s.item.is_case_insensitive_equal_general ("true")
			else
				check is_boolean: False end
			end
		end

	number_from_json (v: JSON_VALUE; a_type: detachable TYPE [detachable ANY]): detachable ANY
		do
			if attached {JSON_NUMBER} v as l_number then
				if a_type = Void then
					Result := l_number.integer_64_item
				elseif a_type = {INTEGER_8} then
					Result := l_number.integer_64_item
				elseif a_type = {INTEGER_16} then
					Result := l_number.integer_64_item
				elseif a_type = {INTEGER_32} then
					Result := l_number.integer_64_item
				elseif a_type = {INTEGER_64} then
					Result := l_number.integer_64_item
				elseif a_type = {NATURAL_8} then
					Result := l_number.natural_64_item
				elseif a_type = {NATURAL_16} then
					Result := l_number.natural_64_item
				elseif a_type = {NATURAL_32} then
					Result := l_number.natural_64_item
				elseif a_type = {NATURAL_64} then
					Result := l_number.natural_64_item
				elseif a_type = {REAL_32} then
					Result := l_number.natural_64_item
				elseif a_type = {REAL_64} then
					Result := l_number.natural_64_item
				else
					Result := l_number.integer_64_item
				end
			end
		end

	integer_from_json (v: JSON_VALUE): INTEGER_64
		do
			if attached {JSON_NUMBER} v as n then
				Result := n.integer_64_item
			elseif attached {JSON_STRING} v as s then
				if s.item.is_integer_64 then
					Result := s.item.to_integer_64
				end
			else
				check is_integer: False end
			end
		end

	natural_from_json (v: JSON_VALUE): NATURAL_64
		do
			if attached {JSON_NUMBER} v as n then
				Result := n.natural_64_item
			elseif attached {JSON_STRING} v as s then
				if s.item.is_natural_64 then
					Result := s.item.to_natural_64
				end
			else
				check is_natural: False end
			end
		end

	real_from_json (v: JSON_VALUE): REAL_64
		do
			if attached {JSON_NUMBER} v as n then
				Result := n.real_64_item
			else
				check is_real: False end
			end
		end

	string_from_json (v: JSON_VALUE; a_static_type: detachable TYPE [detachable ANY]): detachable READABLE_STRING_GENERAL
		do
			if attached {JSON_STRING} v as s then
				if a_static_type /= Void then
					Result := string_converted_to_type (s.unescaped_string_32, a_static_type)
				else
					Result := s.unescaped_string_32
				end
			else
				check is_string: False end
			end
		end

feature {NONE} -- Implementation

	fields_infos (ref: REFLECTED_OBJECT): STRING_TABLE [TUPLE [field_index: INTEGER; field_type_id: INTEGER; static_type: detachable TYPE [detachable ANY]]]
			-- Table indexed by field name of field_type (abstract type, basic types , ref type)
			--	and `static_type' for reference fields.
		local
			fn: READABLE_STRING_GENERAL
			i,n: INTEGER
			tid,stid: INTEGER
			t: detachable TYPE [detachable ANY]
			tb: like fields_infos_by_type_id
		do
			tb := fields_infos_by_type_id
			if tb = Void then
				create tb.make (0)
				fields_infos_by_type_id := tb
			end
			if attached tb.item (ref.type_name) as res then
				Result := res
			else
				n := ref.field_count
				create Result.make_caseless (n)
				from
					i := 1
				until
					i > n
				loop
					fn := ref.field_name (i)
					stid := ref.field_static_type (i)
					tid := ref.field_type (i)
					if stid >= 0 and (tid = reference_type or tid = expanded_type) then
						t := type_of_type (stid)
					else
						t := Void
					end
					Result.force ([i, tid, t], fn)
					i := i + 1
				end
				tb.put (Result, ref.type_name)
			end
		end

	fields_infos_by_type_id: detachable STRING_TABLE [like fields_infos]

	string_converted_to_type (str: READABLE_STRING_GENERAL; a_static_type: TYPE [detachable ANY]): detachable READABLE_STRING_GENERAL
		local
			utf_conv: UTF_CONVERTER
		do
			if a_static_type.conforms_to (str.generating_type) then
				Result := str
			elseif
				a_static_type = {STRING_32} or a_static_type = {detachable STRING_32}
				or a_static_type = {READABLE_STRING_32} or a_static_type = {detachable READABLE_STRING_32}
			then
				create {STRING_32} Result.make_from_string_general (str)
			elseif
				a_static_type = {STRING_8} or a_static_type = {detachable STRING_8}
				or a_static_type = {READABLE_STRING_8} or a_static_type = {detachable READABLE_STRING_8}
			then
				create {STRING_8} Result.make_from_string (utf_conv.utf_32_string_to_utf_8_string_8 (str))

			elseif a_static_type = {IMMUTABLE_STRING_32} or a_static_type = {detachable IMMUTABLE_STRING_32} then
				create {IMMUTABLE_STRING_32} Result.make_from_string_general (str)
			elseif a_static_type = {IMMUTABLE_STRING_8} or a_static_type = {detachable IMMUTABLE_STRING_8} then
				create {IMMUTABLE_STRING_8} Result.make_from_string (utf_conv.utf_32_string_to_utf_8_string_8 (str))

			else
				check known_type: False end
				Result := str
			end
		end

note
	copyright: "2010-2016, Javier Velilla and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
