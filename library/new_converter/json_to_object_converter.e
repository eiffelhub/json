note
	description: "A JSON to object converter"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	JSON_TO_OBJECT_CONVERTER

inherit

	BASE_JSON_CONVERTER

feature -- Conversion

	from_json (j: attached JSON_VALUE): detachable like object
			-- Convert from JSON value.
			-- Returns Void if unable to convert
		deferred
		end

note
	copyright: "2010-2015, Javier Velilla and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
