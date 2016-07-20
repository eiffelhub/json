note
	description: "Summary description for {JSON_SERIALIZATION_FACTORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

expanded class
	JSON_SERIALIZATION_FACTORY

feature -- Factory

	reflector_serialization: JSON_SERIALIZATION
		do
			create Result
			Result.register_default (create {JSON_REFLECTOR_SERIALIZATION})
		end

	smart_serialization: JSON_SERIALIZATION
		do
			create Result
			Result.register_default (create {JSON_REFLECTOR_SERIALIZATION})
			Result.context.register_serializer (create {TABLE_ITERABLE_JSON_SERIALIZER [detachable ANY, READABLE_STRING_GENERAL]}, {TABLE_ITERABLE [detachable ANY, READABLE_STRING_GENERAL]})
			Result.context.register_serializer (create {ITERABLE_JSON_SERIALIZER [detachable ANY]}, {ITERABLE [detachable ANY]})
			Result.context.register_deserializer (create {LIST_JSON_DESERIALIZER [detachable ANY]}, {LIST [detachable ANY]})
			Result.context.register_deserializer (create {TABLE_JSON_DESERIALIZER [detachable ANY]}, {TABLE [detachable ANY, READABLE_STRING_GENERAL]})
		end

note
	copyright: "2010-2016, Javier Velilla and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
