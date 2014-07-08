note
	description: "[
		JSON_ARRAY represent an array in JSON.
		An array in JSON is an ordered set of names.
		Examples
		array
		    []
		    [elements]
	]"
	author: "Javier Velilla"
	date: "2008/08/24"
	revision: "Revision 0.1"

class
	JSON_ARRAY

inherit

	JSON_VALUE
		redefine
			default_create
		end

	ITERABLE [JSON_VALUE]
		undefine
			default_create
		end

	DEBUG_OUTPUT
		undefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create
			-- Initialize JSON Array.
		do
			create values.make (10)
		end

feature -- Access

	i_th alias "[]" (i: INTEGER): JSON_VALUE
			-- Item at `i'-th position.
		require
			is_valid_index: valid_index (i)
		do
			Result := values.i_th (i)
		end

	representation: STRING
			-- <Precursor>
		do
			create Result.make (count * 2 + 1)
			Result.append_character ('[')
			if is_empty then
				Result.append_character (']')
			else
				across
					Current as it
				loop
					Result.append (it.item.representation)
					Result.append_character (',')
				end
				Result [Result.count] := ']'
			end
		end

feature -- Visitor pattern

	accept (a_visitor: JSON_VISITOR)
			-- Accept `a_visitor'.
			-- (Call `visit_json_array' procedure on `a_visitor'.).
		do
			a_visitor.visit_json_array (Current)
		end

feature -- Access

	new_cursor: ITERATION_CURSOR [JSON_VALUE]
			-- Fresh cursor associated with current structure.
		do
			Result := values.new_cursor
		end

feature -- Mesurement

	count: INTEGER
			-- Number of items.
		do
			Result := values.count
		end

feature -- Status report

	valid_index (i: INTEGER): BOOLEAN
			-- Is `i' a valid index?
		do
			Result := (1 <= i) and (i <= count)
		end

	is_empty: BOOLEAN
			-- Has no items?
		do
			Result := values.is_empty
		end

feature -- Change Element

	put_front (v: JSON_VALUE)
		require
			v_not_void: v /= Void
		do
			values.put_front (v)
		ensure
			has_new_value: old values.count + 1 = values.count and values.first = v
		end

	extend (v: JSON_VALUE)
			-- Add `v'.
		require
			v_not_void: v /= Void
		do
			values.extend (v)
		ensure
			has_new_value: old values.count + 1 = values.count and values.has (v)
		end

	prune_all (v: JSON_VALUE)
			-- Remove all occurrences of `v'.
		require
			v_not_void: v /= Void
		do
			values.prune_all (v)
		ensure
			not_has_new_value: not values.has (v)
		end

	wipe_out
			-- Remove all items.
		do
			values.wipe_out
		end

feature -- Report

	hash_code: INTEGER
			-- Hash code value
		do
			Result := 0
			across
				values as it
			loop
				Result := ((Result \\ 8388593) |<< 8) + it.item.hash_code
			end
			Result := Result \\ values.count
		end

feature -- Conversion

	array_representation: ARRAYED_LIST [JSON_VALUE]
			-- Representation as a sequences of values
			-- be careful, modifying the return object may have impact on the original JSON_ARRAY object.
		do
			Result := values
		end

feature -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := count.out + " item(s)"
		end

feature {NONE} -- Implementation

	values: ARRAYED_LIST [JSON_VALUE]
			-- Value container.

invariant
	value_not_void: values /= Void

end
