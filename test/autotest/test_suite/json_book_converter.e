note
	description: "A JSON converter for BOOK"
	author: "Paul Cohen"
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_BOOK_CONVERTER

inherit

	JSON_CONVERTER

create
	default_create

feature -- Conversion

	from_json (j: like to_json): detachable BOOK
			-- <Precursor>
		do
			if
				attached {STRING_32} json.object (j.item (title_key), Void) as l_title and
				attached {STRING_32} json.object (j.item (isbn_key), Void) as l_isbn and
				attached {AUTHOR} json.object (j.item (author_key), {AUTHOR}) as l_author
			then
				create Result.make (l_title, l_author, l_isbn)
			end
		end

	to_json (o: attached like from_json): JSON_OBJECT
			-- <Precursor>
		do
			create Result.make
			Result.put (json.value (o.title), title_key)
			Result.put (json.value (o.isbn), isbn_key)
			Result.put (json.value (o.author), author_key)
		end

feature {NONE} -- Implementation

	title_key: JSON_STRING
			-- Book's title label.
		once
			create Result.make_json ("title")
		end

	isbn_key: JSON_STRING
			-- Book ISBN label.
		once
			create Result.make_json ("isbn")
		end

	author_key: JSON_STRING
			-- Author label.
		once
			create Result.make_json ("author")
		end

end -- class JSON_BOOK_CONVERTER
