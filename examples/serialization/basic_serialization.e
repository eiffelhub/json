note
	description: "[
			Enter class description here!
		]"

class
	BASIC_SERIALIZATION

create
	make

feature {NONE} -- Initialization

	make
		local
			conv: JSON_BASIC_SERIALIZATION
			json: STRING
			p: JSON_PARSER
		do
			print ("%N")
			print ("================================================%N")
			print ("= Serialization using only basic functionality =%N")
			print ("================================================%N")
			print ("%N")
			json := "[
				{ 
					"name": "John",
					"city": "New York",
					"has_records": true,
					"records": [
						{
							"id": 1,
							"city": "Los Angeles",
							"date": "2017"
						},
						{
							"id": 2,
							"city": "San Francisco",
							"date": "2016",
							"notes": null
						},
						{
							"id": 2,
							"city": "Santa Barbara",
							"date": "2015",
							"notes": ["a", "b", "c", { "line-1": 123, "line-2": "abc"} ]
						}
					] 
				}
			]"

				-- Convert json to Eiffel objects, using STRING_TABLE, ARRAYED_LIST and basic types.
			create conv.make
			if attached conv.table_from_json_string (json) as tb then
				print ("%NConverted Table...%N")
				output_object (tb, "")

				conv.set_compact_printing
				print ("%NCompact serialization:%N")
				print (conv.to_json_string (tb))
				print ("%NPretty serialization:%N")
				conv.set_pretty_printing
				print (conv.to_json_string (tb))
			end

				-- Extract the "records" json array, to test the json array conversion to Eiffel.
			create p.make_with_string (json)
			p.parse_content
			if
				p.is_parsed and p.is_valid and then
				attached p.parsed_json_object as j_obj and then
				attached j_obj["records"] as j_records
			then
				print ("%NConverted array %"records%"...%N")
				print ("%N")
				if attached conv.list_from_json_string (j_records.representation) as lst then
					output_object (lst, "")
					conv.set_compact_printing
					print ("%NCompact serialization:%N")
					print (conv.to_json_string (lst))
					print ("%NPretty serialization:%N")
					conv.set_pretty_printing
					print (conv.to_json_string (lst))
				end
			end
		end

feature {NONE} -- Implementation

	output_object (obj: detachable ANY; a_offset: STRING)
		local
			l_offset: STRING
		do
				-- Warning: it should use the localication printer due to potential unicode value...
			if obj = Void then
				print ("Void")
				print ("%N")
			elseif attached {READABLE_STRING_GENERAL} obj as str then
				print ("%"")
				print (str)
				print ("%"%N")
			elseif attached {TABLE_ITERABLE [detachable ANY, READABLE_STRING_GENERAL]} obj as tb then
				print (tb.generator + " {%N")
				l_offset := a_offset + "  "
				across
					tb as ic
				loop
					print (l_offset)
					print (ic.key)
					print (" => ")
					output_object (ic.item, l_offset + "  ")
				end
				print (a_offset)
				print ("}%N")
			elseif attached {ITERABLE [detachable ANY]} obj as lst then
				print (lst.generator + " [%N")
				l_offset := a_offset + "  "
				across
					lst as ic
				loop
					print (l_offset)
					output_object (ic.item, l_offset + "  ")
				end
				print (a_offset)
				print ("]%N")
			else
				print (obj)
				print ("%N")
			end
		end

end
