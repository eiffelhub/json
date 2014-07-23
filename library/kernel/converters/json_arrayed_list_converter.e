note
	description: "A JSON converter for ARRAYED_LIST [ANY]"
	author: "Paul Cohen"
	date: "$Date$"
	revision: "$Revision$"
	file: "$HeadURL: $"

class
	JSON_ARRAYED_LIST_CONVERTER

inherit

	JSON_LIST_CONVERTER

create
	default_create

feature -- Factory

	new_object (nb: INTEGER): ARRAYED_LIST [detachable ANY]
			-- <Precursor>
		do
			create Result.make (nb)
		end

end -- class JSON_ARRAYED_LIST_CONVERTER
