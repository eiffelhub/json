note
	description: "[
			Enter class description here!
		]"

class
	CUSTOM_SERIALIZATION

inherit
	OUTPUT_UTILITIES

create
	make

feature {NONE} -- Initialization

	make
		local
			fac: JSON_SERIALIZATION_FACTORY
			conv: JSON_SERIALIZATION
			p,p2: PERSON
			t: TEAM
			s: STRING
		do
			p := person_john_smith

			create conv
			conv.set_pretty_printing
			conv.register_default (create {JSON_REFLECTOR_SERIALIZATION}) -- for PERSON_DETAILS
			conv.register (create {TEAM_JSON_SERIALIZATION}, {detachable TEAM})
			conv.register (create {PERSON_JSON_SERIALIZATION}, {detachable PERSON})

			s := conv.to_json_string (p)
			print (s)
			print ("%N")

			if attached {PERSON} conv.from_json_string (s, {PERSON}) as l_person then
				print (l_person)
			end

				-- Now to handle a team
			create t.make ("The testers")
			p2 := person_gustave_eiffel
			t.put (p)
			t.put (p2)
			p.add_co_worker (p2)
			print (t)
			s := conv.to_json_string (t)
			print (s)
			print ("%N")

			if attached {TEAM} conv.from_json_string (s, {TEAM}) as l_team then
				print (l_team)
			end
		end

feature -- Object factory		

	person_john_smith: PERSON
		do
			create Result.make ("John", "Smith")
			Result.set_details (create {PERSON_DETAILS}.make (10001, "New York", "USA"))
		end

	person_gustave_eiffel: PERSON
		do
			create Result.make ("Gustave", "Eiffel")
			Result.set_details (create {PERSON_DETAILS}.make (75007, "Paris", "France"))
		end

end
