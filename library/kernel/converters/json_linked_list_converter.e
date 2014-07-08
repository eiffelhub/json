note
	description: "A JSON converter for LINKED_LIST [ANY]"
	author: "Paul Cohen"
	date: "$Date$"
	revision: "$Revision$"
	file: "$HeadURL: $"

class
	JSON_LINKED_LIST_CONVERTER

inherit

	JSON_LIST_CONVERTER

create
	default_create

feature -- Factory

	new_object (nb: INTEGER): LINKED_LIST [detachable ANY]
			-- <Precursor>
		do
			create Result.make
		end

end -- class JSON_LINKED_LIST_CONVERTER
