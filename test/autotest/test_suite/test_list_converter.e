note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_LIST_CONVERTER

inherit
	EQA_TEST_SET

feature -- Test routines

	list_to_json_test
			-- Convert a List into JSON representation.
		local
			list: LINKED_LIST[INTEGER]
			l2j: LINKED_LIST_TO_JSON_CONVERTER
		do
			create list.make
			list.force (1)
			list.force (2)
			list.force (3)
			list.force (4)
			list.force (5)
			create l2j.make
			if attached {JSON_ARRAY}l2j.to_json (list) as l_array then
				assert ("Expected JSON_ARRAY", l_array.representation.same_string ("[1,2,3,4,5]"))
			end
		end


	json_to_list_test
			-- Convert a JSON representation to LIST
		local
			j2l: JSON_TO_LINKED_LIST_CONVERTER
			j: JSON_PARSER
		do
			create j.make_with_string ("{%"a%":[1,2,3,4,5]}")
			j.parse_content
			if
				attached {JSON_OBJECT} j.parsed_json_object as jo and then
				attached {JSON_ARRAY} jo.item ("a") as ja then
				create j2l.make
				if attached j2l.from_json (ja) as l_list then
					if attached {INTEGER_8} l_list.at (1) as element then
						assert ("Expected 1", element = 1)
					end
				end
			end
		end


end


