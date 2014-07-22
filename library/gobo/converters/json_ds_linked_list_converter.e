note
    description: "A JSON converter for DS_LINKED_LIST [ANY]"
    author: "Paul Cohen"
    date: "$Date: $"
    revision: "$Revision: $"
    file: "$HeadURL: $"

class JSON_DS_LINKED_LIST_CONVERTER

inherit
    JSON_CONVERTER

feature -- Conversion

    from_json (j: like to_json): DS_LINKED_LIST [detachable ANY]
        local
            i: INTEGER
        do
            create Result.make
            from
                i := 1
            until
                i > j.count
            loop
                Result.put_last (json.instance (j [i], Void))
                i := i + 1
            end
        end

    to_json (o: like from_json): JSON_ARRAY
        local
            c: DS_LIST_CURSOR [ANY]
        do
            create Result
            from
                c := o.new_cursor
                c.start
            until
                c.after
            loop
                Result.extend (json.value (c.item))
                c.forth
            end
        end

end -- class JSON_DS_LINKED_LIST_CONVERTER
