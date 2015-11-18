note
	description: "A JSON converter for LINKED_LIST [ANY]"
	date: "$Date$"
	revision: "$Revision$"

class
	LINKED_LIST_TO_JSON_CONVERTER

inherit

	LIST_TO_JSON_CONVERTER
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

	object_to_json_attached: object_to_json /= Void

note
	copyright: "2010-2015, Javier Velilla and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
