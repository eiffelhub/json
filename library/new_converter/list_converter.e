note
	description: "Generic List Converter from Eiffel to JSON and JSON to EIffel"
	date: "$Date$"
	revision: "$Revision$"

class
	LIST_CONVERTER

feature -- Converter

	to_json (object_to_json: OBJECT_TO_JSON; o: LIST[detachable ANY]): detachable JSON_ARRAY
			-- Convert an object `o' to a JSON representation.
		local
			c: ITERATION_CURSOR [detachable ANY]
			failed: BOOLEAN
		do
			create Result.make (o.count)
			from
				c := o.new_cursor
			until
				c.after
			loop
				if attached object_to_json.value (c.item) as jv then
					Result.add (jv)
				else
					failed := True
				end
				c.forth
			end
			if failed then
				Result := Void
			end
		end


	from_json (object_to_json: JSON_TO_OBJECT; j: attached JSON_ARRAY; a_target: like {JSON_TO_LIST_CONVERTER}.object): detachable like {JSON_TO_LIST_CONVERTER}.object
		local
			i: INTEGER
		do
			Result := a_target.twin
			from
				i := 1
			until
				i > j.count
			loop
				Result.extend (object_to_json.object (j [i], Void))
				i := i + 1
			end
		end

note
	copyright: "2010-2015, Javier Velilla and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
