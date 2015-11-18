note
	description: "Generic JSON List representation to Eiffel Object"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	JSON_TO_LIST_CONVERTER

inherit

	JSON_TO_OBJECT_CONVERTER
		redefine
			object
		end

feature {NONE} -- Initialization

	make
			-- Initialization
		do
			object := new_object (0)
			json_to_object := (create {EJSON_FACTORY}).new_json_to_object
		end

	make_with_converters (a_converters: LIST[JSON_TO_OBJECT_CONVERTER])
		do
			object := new_object (0)
			json_to_object := (create {EJSON_FACTORY}).new_json_to_object_with_converters (a_converters)
		end

feature -- Access

	json_to_object: JSON_TO_OBJECT
			-- object factory to create an Eiffel object from a JSON representation

	object: LIST [detachable ANY]
			-- <Precursor>

feature {NONE} -- Factory

	new_object (nb: INTEGER): like object
			--  Object factory
		deferred
		end

feature -- Conversion

	from_json (j: attached JSON_ARRAY): detachable LIST [detachable ANY]
			-- Convert a json representation to an Eiffel object.
		local
			i: INTEGER
		do
			Result := (create {LIST_CONVERTER}).from_json (json_to_object, j, new_object (j.count))
		end
note
	copyright: "2010-2015, Javier Velilla and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
