indexing
	description: "A JSON converter"
	author: "Paul Cohen"
	date: "$Date: $"
	revision: "$Revision: $"
	file: "$HeadURL: $"

deferred class JSON_CONVERTER

inherit    
    SHARED_JSON_FACTORY

feature -- Access

    json: JSON_VALUE is
            -- JSON value
        deferred
        end
        
    object: ANY is
            -- Eiffel object
        deferred
        end
            
feature -- Conversion

    from_json (j: like json): like object is
            -- Convert from JSON value. Returns Void if unable to convert
        deferred
        end
        
    to_json (o: like object): like json is
            -- Convert to JSON value
        deferred
        end

invariant
    eiffel_object: object /= Void -- An empty object must be created at creation time!
    
end -- class JSON_CONVERTER