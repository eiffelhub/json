note
	description: "JSON list converter to Eiffel Linked List object."
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_TO_LINKED_LIST_CONVERTER

inherit

	JSON_TO_LIST_CONVERTER
		redefine
			object
		end

create
	make, make_with_converters

feature -- Access

	object: LINKED_LIST [detachable ANY]
			-- <Precursor>

feature {NONE} -- Factory

	new_object (nb: INTEGER): like object
			-- <Precursor>
		do
			create Result.make
		end

invariant

	json_to_object_attached: json_to_object /= Void

note
	copyright: "2010-2015, Javier Velilla and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
