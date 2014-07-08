note
	description: "A JSON converter for BOOK_COLLECTION"
	author: "Paul Cohen"
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_BOOK_COLLECTION_CONVERTER

inherit

	JSON_CONVERTER

create
	default_create

feature -- Conversion

	from_json (j: like to_json): detachable BOOK_COLLECTION
			-- <Precursor>
		local
			l_books: LINKED_LIST [BOOK]
		do
			if
				attached {STRING_32} json.object (j.item (name_key), Void) as l_name and
				attached {JSON_ARRAY} j.item (books_key) as l_json_array
			then
				create Result.make (l_name)
				create l_books.make
				across
					l_json_array as it
				until
					Result = Void
				loop
					if attached {BOOK} json.object (it.item, {BOOK}) as l_book then
						l_books.extend (l_book)
					else
						Result := Void
							-- Failed
					end
				end
				if Result /= Void then
					Result.add_books (l_books)
				end
			end
		end

	to_json (o: attached like from_json): JSON_OBJECT
			-- <Precursor>
		do
			create Result
			Result.put (json.value (o.name), name_key)
			Result.put (json.value (o.books), books_key)
		end

feature {NONE} -- Implementation

	name_key: JSON_STRING
			-- Collection's name label.
		once
			create Result.make_json ("name")
		end

	books_key: JSON_STRING
			-- Book list label.
		once
			create Result.make_json ("books")
		end

end -- class JSON_BOOK_COLLECTION_CONVERTER
