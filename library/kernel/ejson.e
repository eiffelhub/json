note
	description: "Core factory class for creating JSON objects and corresponding Eiffel objects."
	author: "Paul Cohen"
	date: "$Date$"
	revision: "$Revision$"
	file: "$HeadURL: $"

class
	EJSON

inherit

	EXCEPTIONS
		redefine
			default_create
		end

inherit {NONE}

	REFLECTOR
		export
			{NONE} all
		undefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create
			-- Create with no converters.
		do
			create converters.make (10)
			create json_parser
		end

feature -- Access

	value (an_object: detachable ANY): detachable JSON_VALUE
			-- JSON value from Eiffel object. Raises an "eJSON exception" if
			-- unable to convert value.
		local
			ja: JSON_ARRAY
		do
				-- Try to convert from basic Eiffel types. Note that we check with
				-- `conforms_to' since the client may have subclassed the base class
				-- that these basic types are derived from.
			if an_object = Void then
				create {JSON_NULL} Result
			elseif attached {BOOLEAN} an_object as b then
				create {JSON_BOOLEAN} Result.make_boolean (b)
			elseif attached {INTEGER_8} an_object as i8 then
				create {JSON_NUMBER} Result.make_integer (i8)
			elseif attached {INTEGER_16} an_object as i16 then
				create {JSON_NUMBER} Result.make_integer (i16)
			elseif attached {INTEGER_32} an_object as i32 then
				create {JSON_NUMBER} Result.make_integer (i32)
			elseif attached {INTEGER_64} an_object as i64 then
				create {JSON_NUMBER} Result.make_integer (i64)
			elseif attached {NATURAL_8} an_object as n8 then
				create {JSON_NUMBER} Result.make_natural (n8)
			elseif attached {NATURAL_16} an_object as n16 then
				create {JSON_NUMBER} Result.make_natural (n16)
			elseif attached {NATURAL_32} an_object as n32 then
				create {JSON_NUMBER} Result.make_natural (n32)
			elseif attached {NATURAL_64} an_object as n64 then
				create {JSON_NUMBER} Result.make_natural (n64)
			elseif attached {REAL_32} an_object as r32 then
				create {JSON_NUMBER} Result.make_real (r32)
			elseif attached {REAL_64} an_object as r64 then
				create {JSON_NUMBER} Result.make_real (r64)
			elseif attached {ARRAY [detachable ANY]} an_object as a then
				create ja
				across
					a as it
				loop
					if attached value (it.item) as l_value then
						ja.extend (l_value)
					else
						check
							value_attached: False
						end
					end
				end
				Result := ja
			elseif attached {CHARACTER_8} an_object as c8 then
				create {JSON_STRING} Result.make_json (c8.out)
			elseif attached {CHARACTER_32} an_object as c32 then
				create {JSON_STRING} Result.make_json (c32.out)
			elseif attached {STRING_8} an_object as s8 then
				create {JSON_STRING} Result.make_json (s8)
			elseif attached {STRING_32} an_object as s32 then
				create {JSON_STRING} Result.make_json_from_string_32 (s32)
			else
					-- Now check the converters
				if an_object /= Void and then attached converter_for (an_object) as jc then
					Result := jc.to_json (an_object)
				else
					raise (exception_failed_to_convert_to_json (an_object))
				end
			end
		end

	object (a_value: detachable JSON_VALUE; a_type: detachable TYPE [detachable ANY]): detachable ANY
			-- Eiffel object from JSON value. If `base_class' /= Void an eiffel
			-- object based on `base_class' will be returned. Raises an "eJSON
			-- exception" if unable to convert value.
		do
			if a_value = Void then
				Result := Void
			else
				if a_type = Void then
					if attached {JSON_NULL} a_value then
						Result := Void
					elseif attached {JSON_BOOLEAN} a_value as jb then
						Result := jb.item
					elseif attached {JSON_NUMBER} a_value as jn then
						if jn.item.is_integer_8 then
							Result := jn.item.to_integer_8
						elseif jn.item.is_integer_16 then
							Result := jn.item.to_integer_16
						elseif jn.item.is_integer_32 then
							Result := jn.item.to_integer_32
						elseif jn.item.is_integer_64 then
							Result := jn.item.to_integer_64
						elseif jn.item.is_natural_64 then
							Result := jn.item.to_natural_64
						elseif jn.item.is_double then
							Result := jn.item.to_double
						end
					elseif attached {JSON_STRING} a_value as js then
						create {STRING_32} Result.make_from_string (js.unescaped_string_32)
					elseif attached {JSON_ARRAY} a_value as ja then
						Result := default_json_array_converter.from_json (ja)
					elseif attached {JSON_OBJECT} a_value as jo then
						Result := default_json_object_converter.from_json (jo)
					end
				else
					if attached converter_of (a_type) as l_converter then
						Result := l_converter.from_json (a_value)
					else
						raise (exception_failed_to_convert_to_eiffel (a_value, a_type))
					end
				end
			end
		end

	object_from_json (a_json: STRING; a_type: detachable TYPE [detachable ANY]): detachable ANY
			-- Eiffel object from JSON representation. If `a_type' /= Void an
			-- Eiffel object based on `a_type' will be returned. Raises an
			-- "eJSON exception" if unable to convert value.
		require
			json_not_void: a_json /= Void
		do
			json_parser.set_representation (a_json)
			if attached json_parser.parse as l_value then
				Result := object (l_value, a_type)
			end
		end

	converter_of (a_type: TYPE [detachable ANY]): detachable JSON_CONVERTER
			-- Converter of `a_type',
			-- or Void if none registered.
		require
			a_type_attached: a_type /= Void
		do
			if converters.has_key (class_name_of_type (a_type.type_id)) then
				Result := converters.found_item
			end
		end

	converter_for (a_object: ANY): detachable JSON_CONVERTER
			-- Converter for `a_object',
			-- or Void if none registered.
		require
			an_object_not_void: a_object /= Void
		do
			if converters.has_key (a_object.generator) then
				Result := converters.found_item
			end
		end

	json_reference (s: STRING): JSON_OBJECT
			-- A JSON (Dojo style) reference object using `s' as the
			-- reference value. The caller is responsable for ensuring
			-- the validity of `s' as a json reference.
		require
			s_not_void: s /= Void
		local
			js_key, js_value: JSON_STRING
		do
			create Result
			create js_key.make_json ("$ref")
			create js_value.make_json (s)
			Result.put (js_value, js_key)
		end

	json_references (a_list: LIST [STRING]): JSON_ARRAY
			-- A JSON array of JSON (Dojo style) reference objects using the
			-- strings in `a_list' as reference values. The caller is responsable
			-- for ensuring the validity of all strings in `a_list' as json
			-- references.
		require
			a_list_not_void: a_list /= Void
		do
			create Result
			across
				a_list as it
			loop
				Result.extend (json_reference (it.item))
			end
		end

feature -- Change

	add_converter (jc: JSON_CONVERTER)
			-- Add the converter `jc'.
		require
			jc_not_void: jc /= Void
		do
			converters.force (jc, class_name_of_type (jc.type.type_id))
		ensure
			has_converter: converter_of (jc.type) /= Void
		end

feature {NONE} -- Implementation

	converters: HASH_TABLE [JSON_CONVERTER, IMMUTABLE_STRING_8]
			-- Converters hashed by generator (base class)

	default_json_array_converter: JSON_CONVERTER
			-- Default converter for JSON_ARRAY.
		once
			create {JSON_LINKED_LIST_CONVERTER} Result
		end

	default_json_object_converter: JSON_CONVERTER
			-- Default converter for JSON_OBJECT.
		once
			create {JSON_HASH_TABLE_CONVERTER} Result
		end

feature {NONE} -- Implementation (Exceptions)

	exception_prefix: STRING = "eJSON exception: "
			-- Prefix for all EJSON exception.

	exception_failed_to_convert_to_eiffel (a_value: JSON_VALUE; a_type: TYPE [detachable ANY]): STRING
			-- Exception message for failing to convert a JSON_VALUE to an instance of `a_value'.
		require
			a_type_attached: a_type /= Void
		do
			Result := exception_prefix + "Failed to convert JSON_VALUE to an Eiffel object: " + a_value.generator + " -> {" + class_name_of_type (a_type.type_id) + "}"
		end

	exception_failed_to_convert_to_json (a_object: detachable ANY): STRING
			-- Exception message for failing to convert `a_object' to a JSON_VALUE.
		do
			Result := exception_prefix + "Failed to convert Eiffel object to a JSON_VALUE"
			if a_object /= Void then
				Result.append (" : {" + a_object.generator + "}")
			end
		end

feature {NONE} -- Implementation (JSON parser)

	json_parser: JSON_PARSER
			-- JSON parser.

end -- class EJSON
