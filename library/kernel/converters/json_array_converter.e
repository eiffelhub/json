note
	description: "Json converter for {ARRAY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_ARRAY_CONVERTER

inherit

	JSON_CONVERTER

feature -- Conversion

	from_json (j: attached like to_json): ARRAY [detachable ANY]
			-- <Precursor>
		local
			l_area: SPECIAL [detachable ANY]
		do
			create l_area.make_empty (j.count)
			across
				j as it
			loop
				l_area.extend (it.item)
			end
			create Result.make_from_special (l_area)
		end

	to_json (o: like from_json): detachable JSON_ARRAY
			-- <Precursor>
		do
			create Result
			across
				o as it
			until
				Result = Void
			loop
				if attached json.value (it.item) as l_value then
					Result.extend (l_value)
				else
					Result := Void
						-- Failed
				end
			end
		end

end
