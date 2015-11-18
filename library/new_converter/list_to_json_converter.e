note
	description: "Generic Eiffel List to JSON representation converter"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	LIST_TO_JSON_CONVERTER

inherit

	OBJECT_TO_JSON_CONVERTER
			redefine
				object
			end

feature {NONE} -- Initialization

	make
			-- Initialization
		do
			object := new_object (0)
			object_to_json := (create {EJSON_FACTORY}).new_object_to_json
		end

	make_with_converters (a_converters: LIST[OBJECT_TO_JSON_CONVERTER])
		do
			object := new_object (0)
			object_to_json := (create {EJSON_FACTORY}).new_object_to_json_with_converters (a_converters)
		end

feature -- Access

	object_to_json: OBJECT_TO_JSON
			-- object factory to create a JSON represenation from an Eiffel object.	

	object: LIST [detachable ANY]
			-- <Precursor>

feature {NONE} -- Factory

	new_object (nb: INTEGER): like object
			--  Object factory
		deferred
		end

feature -- Conversion

	to_json (o: like object): detachable JSON_ARRAY
			-- <Precursor>
		do
			Result := (create {LIST_CONVERTER}).to_json (object_to_json, o)
		end


;note
	copyright: "2010-2015, Javier Velilla and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
