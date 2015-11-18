note
	description: "Core factory class for creating Eiffel objects from JSON values"
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_TO_OBJECT

inherit

	EXCEPTIONS

create
	make

feature {NONE} -- Initialization

	make
			-- Initilize object.
		do
			create json_converters.make (10)
			create json_parser.make_with_string ("{}")
		ensure
			json_converters_set: json_converters /= Void
			json_parser_set: json_parser /= Void
		end

feature -- Access

	object (a_value: detachable JSON_VALUE; base_class: detachable STRING): detachable ANY
			-- Eiffel object from JSON value. If `base_class' /= Void an eiffel
			-- object based on `base_class' will be returned. Raises an "eJSON
			-- exception" if unable to convert value.
		local
			i: INTEGER
			ll: LINKED_LIST [detachable ANY]
			t: HASH_TABLE [detachable ANY, STRING_GENERAL]
			keys: ARRAY [JSON_STRING]
		do
			if a_value = Void then
				Result := Void
			else
				if base_class = Void then
					if a_value = Void then
						Result := Void
					elseif attached {JSON_NULL} a_value then
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
						from
							create ll.make
							i := 1
						until
							i > ja.count
						loop
							ll.extend (object (ja [i], Void))
							i := i + 1
						end
						Result := ll
					elseif attached {JSON_OBJECT} a_value as jo then
						keys := jo.current_keys
						create t.make (keys.count)
						from
							i := keys.lower
						until
							i > keys.upper
						loop
							if attached {STRING_GENERAL} object (keys [i], Void) as s then
								t.put (object (jo.item (keys [i]), Void), s)
							end
							i := i + 1
						end
						Result := t
					end
				else
					if json_converters.has_key (base_class) and then attached json_converters.found_item as jc then
						Result := jc.from_json (a_value)
					else
						raise (exception_failed_to_convert_to_eiffel (a_value, base_class))
					end
				end
			end
		end

	object_from_json (json: STRING; base_class: detachable STRING): detachable ANY
			-- Eiffel object from JSON representation. If `base_class' /= Void an
			-- Eiffel object based on `base_class' will be returned. Raises an
			-- "eJSON exception" if unable to convert value.
		require
			json_not_void: json /= Void
		do
			json_parser.set_representation (json)
			json_parser.parse_content
			if json_parser.is_valid and then attached json_parser.parsed_json_value as jv then
				Result := object (jv, base_class)
			end
		end

feature -- Change

	add_json_converter (jc: JSON_TO_OBJECT_CONVERTER)
			-- Add the converter `jc'.
		require
			jc_not_void: jc /= Void
		do
			json_converters.force (jc, jc.object.generator)
		ensure
			has_converter: json_converter_for (jc.object) /= Void
		end

feature -- Converters

	json_converter_for (an_object: ANY): detachable JSON_TO_OBJECT_CONVERTER
			-- Converter for objects. Returns Void if none found.
		require
			an_object_not_void: an_object /= Void
		do
			if json_converters.has_key (an_object.generator) then
				Result := json_converters.found_item
			end
		end

feature {NONE} -- Implemenation

	json_converters: HASH_TABLE [JSON_TO_OBJECT_CONVERTER, STRING]
			-- Converters hashed by generator (base class).

feature {NONE} -- Implementation (Exceptions)

	json_exception_prefix: STRING = "eJSON exception: "

	exception_failed_to_convert_to_eiffel (a_value: JSON_VALUE; base_class: detachable STRING): STRING
			-- Exception message for failing to convert a JSON_VALUE to an instance of `a'.
		do
			Result := json_exception_prefix + "Failed to convert JSON_VALUE to an Eiffel object: " + a_value.generator
			if base_class /= Void then
				Result.append (" -> {" + base_class + "}")
			end
		end

feature {NONE} -- Implementation (JSON parser)

	json_parser: JSON_PARSER
			-- JSON parser.


;note
	copyright: "2010-2015, Javier Velilla and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
