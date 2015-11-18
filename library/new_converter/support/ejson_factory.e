note
	description: "Class to create different Eiffel to JSON or (JSON to Eiffel) conversion stategies."
	date: "$Date$"
	revision: "$Revision$"

class
	EJSON_FACTORY

feature -- Factory: JSON to Object

	new_json_to_object: JSON_TO_OBJECT
			-- Create a json to object, without converters
		do
			create Result.make
		end

	new_json_to_object_with_converters (a_converters: ITERABLE [JSON_TO_OBJECT_CONVERTER]): JSON_TO_OBJECT
			-- Create a json to object, with converters
		require
			not_void: a_converters /= Void
		do
			Result := new_json_to_object
			across
				a_converters as ic
			loop
				Result.add_json_converter (ic.item)
			end
		end

feature -- Factory: Object to JSON

	new_object_to_json: OBJECT_TO_JSON
			-- Create an object to json, without converters
		do
			create Result.make
		end

	new_object_to_json_with_converters (a_converters: ITERABLE [OBJECT_TO_JSON_CONVERTER]): OBJECT_TO_JSON
			-- Create an object to json, with converters
		require
			not_void: a_converters /= Void
		do
			Result := new_object_to_json
			across
				a_converters as ic
			loop
				Result.add_object_converter (ic.item)
			end
		end

feature -- Factory: Object to JSON and JSON to Eiffel

	new_eiffel_to_json (a_j2o_converters: ITERABLE[JSON_TO_OBJECT_CONVERTER]; a_o2j_converters: ITERABLE[OBJECT_TO_JSON_CONVERTER] ): EIFFEL_TO_JSON
				-- Create an object to json, json to object with converters
			require
				not_void_json_to_object: a_j2o_converters /= Void
				not_void_object_to_json: a_o2j_converters /= Void
			do
				create Result.make
				across
					a_o2j_converters as ic
				loop
					Result.add_object_converter (ic.item)
				end
				across
					a_j2o_converters as ic
				loop
					Result.add_json_converter (ic.item)
				end
			end


note
	copyright: "2010-2015, Javier Velilla and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"

end
