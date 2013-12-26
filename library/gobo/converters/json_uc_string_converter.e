note
	description: "JSON UC_STRING converter."
	author: "Olivier Ligot"

class
	JSON_UC_STRING_CONVERTER

inherit
    JSON_CONVERTER

create
    make

feature {NONE} -- Initialization

    make
        do
            create object.make (0)
        end

feature -- Access

    value: JSON_STRING

    object: UC_STRING

feature -- Conversion

    from_json (j: like value): like object
        do
            create Result.make_from_string_general (j.unescaped_string_32)
        end

    to_json (o: like object): like value
        do
			create Result.make_json_from_string_32 (o.as_string_32)
        end

end
