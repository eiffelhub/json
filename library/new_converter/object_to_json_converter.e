note
	description: "An Object to JSON converter interface"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	OBJECT_TO_JSON_CONVERTER

inherit

	BASE_JSON_CONVERTER

feature -- Converter

	to_json (o: like object): detachable JSON_VALUE
			-- Convert to JSON value
		deferred
		end

note
	copyright: "2010-2015, Javier Velilla and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
