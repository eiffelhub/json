note
	description: "Core factory class for creating JSON objects from Eiffel classes"
	date: "$Date$"
	revision: "$Revision$"

class
	OBJECT_TO_JSON

inherit

	EXCEPTIONS

create
	make

feature {NONE} -- Initialization

	make
			-- Initilize object.
		do
			create object_converters.make (10)
			create json_parser.make_with_string ("{}")
		ensure
			object_converters_set: object_converters /= Void
			json_parser_set: json_parser /= Void
		end

feature -- Access

	value (an_object: detachable ANY): detachable JSON_VALUE
			-- JSON value from Eiffel object. Raises an "eJSON exception" if
			-- unable to convert value.
		local
			i: INTEGER
			ja: JSON_ARRAY
		do
				-- Try to convert from basic Eiffel types. Note that we check with
				-- `conforms_to' since the client may have subclassed the base class
				-- that these basic types are derived from.
			if an_object = Void then
				create {JSON_NULL} Result
			elseif attached {BOOLEAN} an_object as b then
				create {JSON_BOOLEAN} Result.make (b)
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
				create ja.make (a.count)
				from
					i := a.lower
				until
					i > a.upper
				loop
					if attached value (a @ i) as v then
						ja.add (v)
					else
						check
							value_attached: False
						end
					end
					i := i + 1
				end
				Result := ja
			elseif attached {CHARACTER_8} an_object as c8 then
				create {JSON_STRING} Result.make_from_string (c8.out)
			elseif attached {CHARACTER_32} an_object as c32 then
				create {JSON_STRING} Result.make_from_string_32 (create {STRING_32}.make_filled (c32, 1))
			elseif attached {STRING_8} an_object as s8 then
				create {JSON_STRING} Result.make_from_string (s8)
			elseif attached {STRING_32} an_object as s32 then
				create {JSON_STRING} Result.make_from_string_32 (s32)
			end
			if Result = Void then
					-- Now check the converters
				if an_object /= Void and then attached object_converter_for (an_object) as jc then
					Result := jc.to_json (an_object)
				else
					raise (exception_failed_to_convert_to_json (an_object))
				end
			end
		end

feature -- Change

	add_object_converter (jc: OBJECT_TO_JSON_CONVERTER)
			-- Add the converter `jc'.
		require
			jc_not_void: jc /= Void
		do
			object_converters.force (jc, jc.object.generator)
		ensure
			has_converter: object_converter_for (jc.object) /= Void
		end

feature -- Converters

	object_converter_for (an_object: ANY): detachable OBJECT_TO_JSON_CONVERTER
			-- Converter for objects. Returns Void if none found.
		require
			an_object_not_void: an_object /= Void
		do
			if object_converters.has_key (an_object.generator) then
				Result := object_converters.found_item
			end
		end

feature {NONE} -- Implemenation

	object_converters: HASH_TABLE [OBJECT_TO_JSON_CONVERTER, STRING]
			-- Converters hashed by generator (base class).

feature {NONE} -- Implementation (Exceptions)

	exception_prefix: STRING = "eJSON exception: "

	exception_failed_to_convert_to_json (an_object: detachable ANY): STRING
			-- Exception message for failing to convert `a' to a JSON_VALUE.
		do
			Result := exception_prefix + "Failed to convert Eiffel object to a JSON_VALUE"
			if an_object /= Void then
				Result.append (" : {" + an_object.generator + "}")
			end
		end

feature {NONE} -- Implementation (JSON parser)

	json_parser: JSON_PARSER
			-- JSON parser.

;note
	copyright: "2010-2015, Javier Velilla and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
