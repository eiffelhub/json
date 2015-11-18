note
	description: "A JSON Converter"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	BASE_JSON_CONVERTER

feature -- Access

	object: ANY
			-- Eiffel object
		deferred
		end

invariant
	has_eiffel_object: object /= Void -- An empty object must be created at creation time!

note
	copyright: "2010-2015, Javier Velilla and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
