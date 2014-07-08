note
	description: "A JSON converter for AUTHOR"
	author: "Paul Cohen"
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_AUTHOR_CONVERTER

inherit

	JSON_CONVERTER

create
	default_create

feature -- Conversion

	from_json (j: like to_json): detachable AUTHOR
			-- <Precursor>
		do
			if attached {STRING_32} json.object (j.item (name_key), Void) as l_name then
				create Result.make (l_name)
			end
		end

	to_json (o: attached like from_json): JSON_OBJECT
			-- <Precursor>
		do
			create Result.make
			Result.put (json.value (o.name), name_key)
		end

feature {NONE} -- Implementation

	name_key: JSON_STRING
			-- Author's name label.
		once
			create Result.make_json ("name")
		end

end -- class JSON_AUTHOR_CONVERTER
