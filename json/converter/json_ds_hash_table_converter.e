indexing
	description: "A JSON converter for DS_HASH_TABLE"
	author: "Paul Cohen"
	date: "$Date: $"
	revision: "$Revision: $"
	file: "$HeadURL: $"

class JSON_DS_HASH_TABLE_CONVERTER

inherit
    JSON_CONVERTER
    
create
    make
    
feature {NONE} -- Initialization
    
    make is
        do
            create object.make (0)
        end
        
feature -- Access

    json: JSON_OBJECT
            
    object: DS_HASH_TABLE [ANY, HASHABLE]
            
feature -- Conversion

    from_json (j: like json): like object is
        local
            keys: ARRAY [JSON_STRING]
            i: INTEGER
            key: HASHABLE
            value: ANY
        do
            keys := j.current_keys
            create Result.make (keys.count)
            from
                i := 1
            until
                i > keys.count
            loop
                key ?= factory.eiffel_object (keys [i], void)
                check key /= Void end
                value := factory.eiffel_object (j.item (keys [i]), Void)
                Result.put (value, key)
                i := i + 1
            end
        end
        
    to_json (o: like object): like json is
        local
            c: DS_HASH_TABLE_CURSOR [ANY, HASHABLE]
            key: JSON_STRING
            value: JSON_VALUE
            failed: BOOLEAN
        do
            create Result.make
            from
                c := o.new_cursor
                c.start
            until
                c.after
            loop
                create key.make_json (c.key.out)
                value := factory.json_value (c.item)
                if value /= Void then
                    Result.put (value, key)
                else
                    failed := True
                end 
                c.forth
            end
            if failed then
                Result := Void
            end
        end
  
end -- class JSON_DS_HASH_TABLE_CONVERTER