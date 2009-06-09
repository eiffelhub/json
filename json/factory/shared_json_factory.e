indexing
    description: "[
                   Shared factory for creating JSON objects. Use expanded 
                   inheritance from this class to ensure that your classes 
                   share the same JSON_FACTORY instance
                  ]"
    author: "Paul Cohen"
    date: "$Date: $"
    revision: "$Revision: $"
    file: "$HeadURL: $"

class SHARED_JSON_FACTORY

feature

    json: JSON_FACTORY is
            -- A shared JSON_FACTORY instance with default converters for
            -- DS_LINKED_LIST [ANY] and DS_HASH_TABLE [ANY, HASHABLE]
        local
            jllc: JSON_DS_LINKED_LIST_CONVERTER
            jhtc: JSON_DS_HASH_TABLE_CONVERTER
        once
            create Result
            create jllc.make
            Result.add_converter (jllc)
            create jhtc.make
            Result.add_converter (jhtc)
        end
        
end -- class SHARED_JSON_FACTORY