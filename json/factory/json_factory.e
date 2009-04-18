indexing
	description: "factory for creating JSON objects"
	author: "Paul Cohen"

class JSON_FACTORY

feature -- Access
        
    json_value (object: ?ANY): JSON_VALUE is
            -- JSON value from Eiffel object. Returns Void if unable to 
            -- convert. Check `unconvertable_types' to see which types 
            -- lack a JSON_CONVERTER.
        local
            b: BOOLEAN
            i8: INTEGER_8
            i16: INTEGER_16
            i32: INTEGER_32
            i64: INTEGER_64
            r32: REAL_32
            r64: REAL_64
            s8: STRING_8
            ucs: UC_STRING
            jc: JSON_CONVERTER
        do
            -- Try to convert from basic Eiffel types. Note that we check with
            -- `conforms_to' since the client may have subclassed the base class
            -- that these basic types are derived from.
            if object = Void then
                create {JSON_NULL} Result
            elseif object.conforms_to (a_boolean) then
                b ?= object
                create {JSON_BOOLEAN} Result.make_boolean (b)
            elseif object.conforms_to (an_integer_8) then
                i8 ?= object
                create {JSON_NUMBER} Result.make_integer (i8)
            elseif object.conforms_to (an_integer_16) then
                i16 ?= object
                create {JSON_NUMBER} Result.make_integer (i16)
            elseif object.conforms_to (an_integer_32) then
                i32 ?= object
                create {JSON_NUMBER} Result.make_integer (i32)
--            elseif object.conforms_to (an_integer_64) then
--                i64 ?= object
--                create {JSON_NUMBER} Result.make_integer (i64)
            elseif object.conforms_to (a_real_32) then
                r32 ?= object
                create {JSON_NUMBER} Result.make_real (r32)
            elseif object.conforms_to (a_real_64) then
                r64 ?= object
                create {JSON_NUMBER} Result.make_real (r64)
            elseif object.conforms_to (a_string_8) then
                s8 ?= object
                create {JSON_STRING} Result.make_json (s8)
            elseif object.conforms_to (a_uc_string) then
                ucs ?= object
                create {JSON_STRING} Result.make_json (ucs.to_utf8)
            end
            
            if Result = Void then
                -- Now check the converters
                jc := converter_for (object)
                if jc /= Void then
                    Result := jc.to_json (object)
                else
                    unconvertable_types.put_last (object.generator)
                end
            end
        end

    eiffel_object (value: JSON_VALUE; base_class: ?STRING): ANY is
            -- Eiffel object from JSON value. If `base_class' /= Void an eiffel
            -- object based on `base_class' will be returned. Returns Void if 
            -- unable to convert, ie. there is no JSON_CONVERTER for the given
            -- `base_class'. Check `unconvertable_types' to see which types 
            -- lack a JSON_CONVERTER.
        require
            value_not_void: value /= Void
        local
            jc: JSON_CONVERTER
            jb: JSON_BOOLEAN
            jn: JSON_NUMBER
            js: JSON_STRING
        do
            if base_class = Void then
                if value.generator.is_equal ("JSON_NULL") then
                    Result := Void
                elseif value.generator.is_equal ("JSON_BOOLEAN") then
                    jb ?= value
                    check jb /= Void end
                    Result := jb.item
                elseif value.generator.is_equal ("JSON_NUMBER") then
                    jn ?= value
                    check jn /= Void end
                    if jn.item.is_integer_8 then
                        Result := jn.item.to_integer_8
                    elseif jn.item.is_integer_16 then
                        Result := jn.item.to_integer_16
                    elseif jn.item.is_integer_32 then
                        Result := jn.item.to_integer_32
                    elseif jn.item.is_integer_64 then
                        Result := jn.item.to_integer_64
                    elseif jn.item.is_real then
                        Result := jn.item.to_real
                    elseif jn.item.is_double then
                        Result := jn.item.to_double
                    end
                elseif value.generator.is_equal ("JSON_STRING") then
                    js ?= value
                    check js /= Void end
                    Result := js.item
                end
            else
                if converters.has (base_class) then
                    jc := converters @ base_class
                    Result := jc.from_json (value)
                else
                    Result := Void
                end
            end
        end

    converter_for (object: ANY): JSON_CONVERTER is
            -- Converter for objects. Returns Void if none found.
        require
            object_not_void: object /= Void
        do
            if converters.has (object.generator) then
                Result := converters @ object.generator
            end
        end
        
    unconvertable_types: DS_LINKED_LIST [STRING] is
            -- Name of types for which no converter was found
        once
            create Result.make
        end

feature -- Change

    add_converter (jc: JSON_CONVERTER) is
            -- Add the converter `jc'.
        require
            jc_not_void: jc /= Void
        do
            converters.force (jc, jc.object.generator)
        ensure
            has_converter: converter_for (jc.object) /= Void
        end

feature {NONE} -- Implementation

    converters: DS_HASH_TABLE [JSON_CONVERTER, STRING] is
            -- Converters hashed by generator (base class)
        once
            create Result.make (10)
        end

feature {NONE} -- Implementation (Basic Eiffel objects)

    a_boolean: BOOLEAN
    
    an_integer_8: INTEGER_8

    an_integer_16: INTEGER_16

    an_integer_32: INTEGER_32

    an_integer_64: INTEGER_64

    a_real_32: REAL_32

    a_real_64: REAL_64

    a_string_8: STRING_8 is
        once
            Result := ""
        end

    a_uc_string: UC_STRING is
        once
            create Result.make_from_string ("")
        end
        
end -- class JSON_FACTORY