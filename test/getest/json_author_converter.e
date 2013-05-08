note
    description: "A JSON converter for AUTHOR"
    author: "Paul Cohen"
    date: "$Date$"
    revision: "$Revision$"

class JSON_AUTHOR_CONVERTER

inherit
    JSON_CONVERTER

create
    make

feature {NONE} -- Initialization

    make
        local
            ucs: UC_STRING
        do
            create ucs.make_from_string ("")
            create object.make (ucs)
        end

feature -- Access

    value: JSON_OBJECT

    object: AUTHOR

feature -- Conversion

    from_json (j: like value): like object
        local
            ucs: UC_STRING
        do
            ucs ?= json.object (j.item (name_key), "UC_STRING")
            check ucs /= Void end
            create Result.make (ucs)
        end

    to_json (o: like object): like value
        do
            create Result.make
            Result.put (json.value (o.name), name_key)
        end

feature    {NONE} -- Implementation

    name_key: JSON_STRING
        once
            create Result.make_json ("name")
        end

end -- class JSON_AUTHOR_CONVERTER