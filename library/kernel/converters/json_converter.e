note
	description: "Ancestor for all JSON converters."
	author: "Paul Cohen"
	date: "$Date$"
	revision: "$Revision$"
	file: "$HeadURL: $"

deferred class
	JSON_CONVERTER

inherit

	SHARED_EJSON
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
			-- Create a converter for `type'.
		do
			type := {attached like from_json}
		end

feature -- Access

	type: TYPE [attached like from_json]
			-- Eiffel type.

feature -- Conversion

	from_json (j: attached like to_json): detachable ANY
			-- Convert from JSON value.
			-- Returns Void if unable to convert
		require
			j_attached: j /= Void
		deferred end

	to_json (o: attached like from_json): detachable JSON_VALUE
			-- Convert to JSON value.
		require
			o_attached: o /= Void
		deferred end

invariant
	has_eiffel_type: type /= Void
	attached_type: type.is_attached

end
