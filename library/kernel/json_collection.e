note
	description: "JSON Collection of items"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	JSON_COLLECTION


feature {NONE} -- Implementation

	items: READABLE_INDEXABLE [JSON_VALUE]
			-- Value container

;note
	copyright: "2010-2020, Javier Velilla, Jocelyn Fiat, Eiffel Software and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
