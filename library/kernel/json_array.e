note
	description: "[
		JSON_ARRAY represent an array in JSON.
		An array in JSON is an ordered set of names.
		Examples
		array
		    []
		    [elements]
	]"
	author: "$Author$"
	date: "$date$"
	revision: "$Revision$"

class
	JSON_ARRAY

inherit
	JSON_VALUE
		redefine
			is_array,
			chained_item
		end

	ITERABLE [JSON_VALUE]

	DEBUG_OUTPUT

create
	make,
	make_empty,
--	make_from_separate,
	make_array


feature {NONE} -- Initialization

	make (nb: INTEGER)
			-- Initialize JSON array with capacity of `nb' items.
		do
			create items.make (nb)
		end

	make_empty
			-- Initialize empty JSON array.
		do
			make (0)
		end

	make_array
			-- Initialize JSON Array
		obsolete
			"Use `make' [2017-05-31]"
		do
			make (10)
		end

	make_from_separate (other: separate like Current)
		do
			create items.make (other.count)
			fill_from_separate (other)
		end

feature -- Status report			

	is_array: BOOLEAN = True
			-- <Precursor>

feature -- Access

	i_th alias "[]" (i: INTEGER): like items.item
			-- Item at `i'-th position
		require
			is_valid_index: valid_index (i)
		do
			Result := items.i_th (i)
		end

	chained_item alias "@" (a_key: JSON_STRING): like items.item
			-- <Precursor>.
		do
			if a_key.item.is_integer then
				Result := i_th (a_key.item.to_integer)
			else
				Result := Precursor (a_key)
			end
		end

	representation: STRING
		do
			Result := "["
			across
				items as ic
			loop
				if Result.count > 1 then
					Result.append_character (',')
				end
				Result.append (ic.item.representation)
			end
			Result.append_character (']')
		ensure then
			Result.starts_with ("[")
			Result.ends_with ("]")
		end

feature -- Visitor pattern

	accept (a_visitor: JSON_VISITOR)
			-- Accept `a_visitor'.
			-- (Call `visit_json_array' procedure on `a_visitor'.)
		do
			a_visitor.visit_json_array (Current)
		end

feature -- Access

	new_cursor: ITERATION_CURSOR [like items.item]
			-- Fresh cursor associated with current structure
		do
			Result := items.new_cursor
		end

feature -- Mesurement

	count: INTEGER
			-- Number of items.
		do
			Result := items.count
		end

feature -- Status report

	is_empty: BOOLEAN
			-- Is structure empty?
		do
			Result := count = 0
		end

	valid_index (i: INTEGER): BOOLEAN
			-- Is `i' a valid index?
		do
			Result := (1 <= i) and (i <= count)
		end

feature -- Change Element

	put_front (v: like items.item)
		require
			v_not_void: v /= Void
		do
			items.put_front (v)
		ensure
			has_new_value: old items.count + 1 = items.count and items.first = v
		end

	add, extend (v: like items.item)
		require
			v_not_void: v /= Void
		do
			items.extend (v)
		ensure
			has_new_value: old items.count + 1 = items.count and items.has (v)
		end

	prune_all (v: like items.item)
			-- Remove all occurrences of `v'.
		require
			v_not_void: v /= Void
		do
			items.prune_all (v)
		ensure
			not_has_new_value: not items.has (v)
		end

	fill_from_separate (other: separate like Current)
		do
			check
				not_yet_implemented: False
			end
			across
				other as l_item
			loop
--				extend (l_item.item)
			end
		end

	wipe_out
			-- Remove all items.
		do
			items.wipe_out
		ensure
			is_empty
 		end

feature -- Report

	hash_code: INTEGER
			-- Hash code value
		local
			l_started: BOOLEAN
		do
			across
				items as ic
			loop
				if l_started then
					Result := ((Result \\ 8388593) |<< 8) + ic.item.hash_code
				else
					Result := ic.item.hash_code
					l_started := True
				end
			end
			Result := Result \\ items.count
		end

feature -- Conversion

	array_representation: like items
			-- Representation as a sequences of values.
			-- be careful, modifying the return object may have impact on the original JSON_ARRAY object.		
		do
			Result := items
		end

feature -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := count.out + " item(s)"
		end

feature {NONE} -- Implementation

	items: ARRAYED_LIST [JSON_VALUE]
			-- Value container

invariant
	items_not_void: items /= Void

note
	copyright: "2010-2020, Javier Velilla, Jocelyn Fiat, Eiffel Software and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end
