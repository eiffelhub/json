class
	BASIC

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			parser: JSON_PARSER
			l_stopwatch: DT_STOPWATCH
			i: INTEGER
			mem: MEMORY
		do
			create file_reader
			create mem
				-- Create parser for content `json_content'
			if attached json_file_from (file_name) as json_content then
				from
					i := 1
				until
					i > 10
				loop
					mem.collection_off
					create l_stopwatch.make
					l_stopwatch.start
					create parser.make_with_string (json_content)
					parser.set_default_array_size (25)
					parser.set_default_object_size (10)

					parser.parse_content
					if parser.is_parsed and then parser.is_valid and then not parser.has_error then
						debug
							print ("%NWas valid")
						end
					else
						debug
							print ("%NWas invalid")
						end
					end
					l_stopwatch.stop
					print ("%NElapsed time:" + l_stopwatch.elapsed_time.precise_time_out)
					parser.reset
					i := i + 1
					mem.full_coalesce
					mem.collection_on
					mem.full_collect
				end
				print ("%NPress Enter to exit!!!")
				io.read_line
			end
		end

feature -- Status
feature {NONE} -- Implementation

	file_name: STRING ="YOUR-FILE-NAME"

	file_reader: JSON_FILE_READER
			-- JSON file reader.

	json_file_from (fn: READABLE_STRING_GENERAL): detachable STRING
		local
			f: RAW_FILE
			l_path: PATH
			test_dir: PATH
			i: INTEGER
		do
			test_dir := (create {EXECUTION_ENVIRONMENT}).current_working_path.extended ("data")
			l_path := test_dir.extended (fn)
			create f.make_with_path (l_path)
			if f.exists then
					-- Found json file
			else
				from
					i := 5
				until
					i = 0
				loop
					test_dir := test_dir.extended ("..")
					i := i - 1
				end
				l_path := test_dir.extended (fn)
			end
			create f.make_with_path (l_path)
			if f.exists then
				Result := file_reader.read_json_from (l_path.name)
			end
 			check File_contains_json_data: Result /= Void end
 		end
invariant
end
