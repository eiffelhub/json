indexing
	description:
		"[
		  This class contains test cases. 
                  TODO: Put proper description of class here.
		  Visit http://dev.eiffel.com/CddBranch for more information.
		]"
	author: "EiffelStudio CDD Tool"
	date: "$Date$"
	revision: "$Revision$"
	cdd_id: "6BDE677C-83F4-4406-B846-BCF548A8E6C4"

class
	TEST_JSON_SUITE

inherit
	TS_TEST_CASE

create
    make_default

feature {NONE} -- Initialization

    make is
            -- Create test object.
        do
        end

feature -- Tests Pass

	test_json_pass1 is
    		--
    		do
    				create file_reader
    				json_file:=file_reader.read_json_from ("./suite/pass1.json")
					create parse_json.make_parser (json_file)
					json_value := parse_json.parse_json
		  			assert ("pass1.json",parse_json.is_parsed = True)
    		end

	test_json_pass2 is
    		--
    		do
    				create file_reader
    				json_file:=file_reader.read_json_from ("./suite/pass2.json")
					create parse_json.make_parser (json_file)
					json_value := parse_json.parse
		  			assert ("pass2.json",parse_json.is_parsed = True)
    		end

    test_json_pass3 is
    		--
    		do
    				create file_reader
    				json_file:=file_reader.read_json_from ("./suite/pass3.json")
					create parse_json.make_parser (json_file)
					json_value := parse_json.parse
		  			assert ("pass3.json",parse_json.is_parsed = True)
    		end

feature -- Tests Failures
    test_json_fail1 is
    		--
    		do
    				create file_reader
    				json_file:=file_reader.read_json_from ("./suite/fail1.json")
					create parse_json.make_parser (json_file)
					json_value := parse_json.parse
		  			assert ("fail1.json",parse_json.is_parsed = False)
    		end

    test_json_fail2 is
    		--
    		do
    				create file_reader
    				json_file:=file_reader.read_json_from ("./suite/fail2.json")
					create parse_json.make_parser (json_file)
					json_value := parse_json.parse
		  			assert ("fail2.json",parse_json.is_parsed = False)
    		end

	test_json_fail3 is
    		--
    		do
    				create file_reader
    				json_file:=file_reader.read_json_from ("./suite/fail3.json")
					create parse_json.make_parser (json_file)
					json_value := parse_json.parse
		  			assert ("fail3.json",parse_json.is_parsed = False)
    		end

	test_json_fail4 is
    		--
    		do
    				create file_reader
    				json_file:=file_reader.read_json_from ("./suite/fail4.json")
					create parse_json.make_parser (json_file)
					json_value := parse_json.parse
		  			assert ("fail4.json",parse_json.is_parsed = False)
    		end

    test_json_fail5 is
    		--
    		do
    				create file_reader
    				json_file:=file_reader.read_json_from ("./suite/fail5.json")
					create parse_json.make_parser (json_file)
					json_value := parse_json.parse
		  			assert ("fail5.json",parse_json.is_parsed = False)
    		end


	test_json_fail6 is
    		--
    		do
    				create file_reader
    				json_file:=file_reader.read_json_from ("./suite/fail6.json")
					create parse_json.make_parser (json_file)
					json_value := parse_json.parse
		  			assert ("fail6.json",parse_json.is_parsed = False )
    		end

 	test_json_fail7 is
    		--
    		do
    				create file_reader
    				json_file:=file_reader.read_json_from ("./suite/fail7.json")
					create parse_json.make_parser (json_file)
					json_value := parse_json.parse_json
		  			assert ("fail7.json",parse_json.is_parsed = False)
    		end

  	test_json_fail8 is
    		--
    		do
    				create file_reader
    				json_file:=file_reader.read_json_from ("./suite/fail8.json")
					create parse_json.make_parser (json_file)
					json_value := parse_json.parse_json
		  			assert ("fail8.json",parse_json.is_parsed = False )
    		end


	test_json_fail9 is
    		--
    		do
    				create file_reader
    				json_file:=file_reader.read_json_from ("./suite/fail9.json")
					create parse_json.make_parser (json_file)
					json_value := parse_json.parse
		  			assert ("fail9.json",parse_json.is_parsed = False)
    		end


	test_json_fail10 is
    		--
    		do
    				create file_reader
    				json_file:=file_reader.read_json_from ("./suite/fail10.json")
					create parse_json.make_parser (json_file)
					json_value := parse_json.parse_json
		  			assert ("fail10.json",parse_json.is_parsed = False)
    		end

   	test_json_fail11 is
    		--
    		do
    				create file_reader
    				json_file:=file_reader.read_json_from ("./suite/fail11.json")
					create parse_json.make_parser (json_file)
					json_value := parse_json.parse
		  			assert ("fail11.json",parse_json.is_parsed = False)
    		end

	test_json_fail12 is
    		--
    		do
    				create file_reader
    				json_file:=file_reader.read_json_from ("./suite/fail12.json")
					create parse_json.make_parser (json_file)
					json_value := parse_json.parse
		  			assert ("fail12.json",parse_json.is_parsed = False)
    		end

    test_json_fail13 is
    		--
    		do
    				create file_reader
    				json_file:=file_reader.read_json_from ("./suite/fail13.json")
					create parse_json.make_parser (json_file)
					json_value := parse_json.parse_json
		  			assert ("fail13.json",parse_json.is_parsed = False)
    		end

  	test_json_fail14 is
    		--
    		do
    				create file_reader
    				json_file:=file_reader.read_json_from ("./suite/fail14.json")
					create parse_json.make_parser (json_file)
					json_value := parse_json.parse
		  			assert ("fail14.json",parse_json.is_parsed = False)
    		end

	test_json_fail15 is
    		--
    		do
    				create file_reader
    				json_file:=file_reader.read_json_from ("./suite/fail15.json")
					create parse_json.make_parser (json_file)
					json_value := parse_json.parse_json
		  			assert ("fail15.json",parse_json.is_parsed = False)
    		end

	test_json_fail16 is
    		--
    		do
    				create file_reader
    				json_file:=file_reader.read_json_from ("./suite/fail16.json")
					create parse_json.make_parser (json_file)
					json_value := parse_json.parse
		  			assert ("fail16.json",parse_json.is_parsed = False)
    		end

	test_json_fail17 is
    		--
    		do
    				create file_reader
    				json_file:=file_reader.read_json_from ("./suite/fail17.json")
					create parse_json.make_parser (json_file)
					json_value := parse_json.parse_json
		  			assert ("fail17.json",parse_json.is_parsed = False)
    		end

	test_json_fail18 is
    		--
    		do
    				create file_reader
    				json_file:=file_reader.read_json_from ("./suite/fail18.json")
					create parse_json.make_parser (json_file)
					json_value := parse_json.parse_json
		  			assert ("fail18.json",parse_json.is_parsed = False)
    		end

	test_json_fail19 is
    		--
    		do
    				create file_reader
    				json_file:=file_reader.read_json_from ("./suite/fail19.json")
					create parse_json.make_parser (json_file)
					json_value := parse_json.parse
		  			assert ("fail19.json",parse_json.is_parsed = False)
    		end

	test_json_fail20 is
    		--
    		do
    				create file_reader
    				json_file:=file_reader.read_json_from ("./suite/fail20.json")
					create parse_json.make_parser (json_file)
					json_value := parse_json.parse
		  			assert ("fail20.json",parse_json.is_parsed = False)
    		end

    test_json_fail21 is
    		--
    		do
    				create file_reader
    				json_file:=file_reader.read_json_from ("./suite/fail21.json")
					create parse_json.make_parser (json_file)
					json_value := parse_json.parse
		  			assert ("fail21.json",parse_json.is_parsed = False)
    		end


 	test_json_fail22 is
    		--
    		do
    				create file_reader
    				json_file:=file_reader.read_json_from ("./suite/fail22.json")
					create parse_json.make_parser (json_file)
					json_value := parse_json.parse
		  			assert ("fail22.json",parse_json.is_parsed = False)
    		end

    test_json_fail23 is
    		--
    		do
    				create file_reader
    				json_file:=file_reader.read_json_from ("./suite/fail23.json")
					create parse_json.make_parser (json_file)
					json_value := parse_json.parse
		  			assert ("fail23.json",parse_json.is_parsed = False)
    		end

 	test_json_fail24 is
    		--
    		do
    				create file_reader
    				json_file:=file_reader.read_json_from ("./suite/fail24.json")
					create parse_json.make_parser (json_file)
					json_value := parse_json.parse
		  			assert ("fail24.json",parse_json.is_parsed = False)
    		end

	test_json_fail25 is
    		--
    		do
    				create file_reader
    				json_file:=file_reader.read_json_from ("./suite/fail25.json")
					create parse_json.make_parser (json_file)
					json_value := parse_json.parse_json
		  			assert ("fail25.json",parse_json.is_parsed = False)
    		end


   	test_json_fail26 is
    		--
    		do
    				create file_reader
    				json_file:=file_reader.read_json_from ("./suite/fail26.json")
					create parse_json.make_parser (json_file)
					json_value := parse_json.parse_json
		  			assert ("fail26.json",parse_json.is_parsed = False)
    		end


   	test_json_fail27 is
    		--
    		do
    				create file_reader
    				json_file:=file_reader.read_json_from ("./suite/fail27.json")
					create parse_json.make_parser (json_file)
					json_value := parse_json.parse_json
		  			assert ("fail27.json",parse_json.is_parsed = False)
    		end


   	test_json_fail28 is
    		--
    		do
    				create file_reader
    				json_file:=file_reader.read_json_from ("./suite/fail28.json")
					create parse_json.make_parser (json_file)
					json_value := parse_json.parse
		  			assert ("fail28.json",parse_json.is_parsed = False)
    		end


   	test_json_fail29 is
    		--
    		do
    				create file_reader
    				json_file:=file_reader.read_json_from ("./suite/fail29.json")
					create parse_json.make_parser (json_file)
					json_value := parse_json.parse
		  			assert ("fail29.json",parse_json.is_parsed = False )
    		end


   	test_json_fail30 is
    		--
    		do
    				create file_reader
    				json_file:=file_reader.read_json_from ("./suite/fail30.json")
					create parse_json.make_parser (json_file)
					json_value := parse_json.parse
		  			assert ("fail30.json",parse_json.is_parsed = False)
    		end

	test_json_fail31 is
    		--
    		do
    				create file_reader
    				json_file:=file_reader.read_json_from ("./suite/fail31.json")
					create parse_json.make_parser (json_file)
					json_value := parse_json.parse
		  			assert ("fail31.json",parse_json.is_parsed = False)
    		end

    test_json_fail32 is
    		--
    		do
    				create file_reader
    				json_file:=file_reader.read_json_from ("./suite/fail32.json")
					create parse_json.make_parser (json_file)
					json_value := parse_json.parse
		  			assert ("fail32.json",parse_json.is_parsed = False)
    		end

    test_json_fail33 is
    		--
    		do
    				create file_reader
    				json_file:=file_reader.read_json_from ("./suite/fail33.json")
					create parse_json.make_parser (json_file)
					json_value := parse_json.parse
		  			assert ("fail33.json",parse_json.is_parsed = False)
    		end
feature -- JSON_FROM_FILE
   	json_file:STRING
   	parse_json:JSON_PARSER
 	json_object:JSON_OBJECT
	file_reader:JSON_FILE_READER
	json_value : JSON_VALUE
end
