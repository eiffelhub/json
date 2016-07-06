note
	description: "Summary description for {LIST_JSON_DESERIALIZER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LIST_JSON_DESERIALIZER [G -> detachable ANY]

inherit
	JSON_DESERIALIZER

	JSON_TYPE_UTILITIES

feature -- Conversion

	from_json (a_json: detachable JSON_VALUE; ctx: JSON_DESERIALIZER_CONTEXT; a_type: detachable TYPE [detachable ANY]): detachable LIST [G]
			-- Eiffel value deserialized from `a_json' value, in the eventual context `ctx'.
		do
			if attached {JSON_ARRAY} a_json as j_array then
				Result := new_effective_list (j_array.count, a_type)
				if Result = Void then
					if a_type = Void then
						ctx.on_value_skipped (j_array, a_type, "Could not instantiate array object.")
					else
						ctx.on_value_skipped (j_array, a_type, "Could not instantiate array {" + a_type.name + "}.")
					end
				else
					across
						j_array as ic
					loop
						if attached ctx.deserializer ({G}) as d then
							if attached {G} d.from_json (ic.item, ctx, {G}) as g then
								Result.force (g)
							end
						end
					end
				end
			end
		end

	new_effective_list (a_count: INTEGER; a_type: detachable TYPE [detachable ANY]): detachable LIST [G]
		local
		do
			if
				attached {TYPE [LIST [G]]} a_type as t and then
				attached {LIST [G]} new_instance_of_type (t) as lst
			then
				Result := lst
			end
		end

note
	copyright: "2010-2016, Javier Velilla and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
