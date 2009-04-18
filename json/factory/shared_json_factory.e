class SHARED_JSON_FACTORY

feature

    factory: JSON_FACTORY is
            -- A shared JSON_FACTORY instance
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