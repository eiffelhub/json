note
	description: "Core factory class for creating Eiffel objects from JSON values and JSON Values from Eiffel Objects"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_TO_JSON

inherit

	JSON_TO_OBJECT
		rename
			make as make_json_to_object,
			json_parser as json_parser_to_object
		end
	OBJECT_TO_JSON
		rename
			make as make_object_to_json
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization
		do
			make_json_to_object
			make_object_to_json
		end

note
	copyright: "2010-2015, Javier Velilla and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
