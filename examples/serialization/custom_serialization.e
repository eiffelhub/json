note
	description: "[
			Enter class description here!
		]"

class
	CUSTOM_SERIALIZATION

create
	make

feature {NONE} -- Initialization

	make
		local
			fac: JSON_SERIALIZATION_FACTORY
			conv: JSON_SERIALIZATION
			arr: ARRAYED_LIST [PERSON]
			p: PERSON
			s: STRING
		do
			p := person_john_smith

			create conv
			conv.set_pretty_printing
			conv.register (create {TEAM_JSON_SERIALIZATION}, {TEAM})
			conv.register (create {PERSON_JSON_SERIALIZATION}, {PERSON})
			conv.register_default (create {JSON_REFLECTOR_SERIALIZATION}) -- for PERSON_DETAILS

			s := conv.to_json_string (p)

			if s /= Void and then attached {PERSON} conv.from_json_string (s, {PERSON}) as l_person then
				print (l_person)
			end


				-- Now to handle a list of persons.			
			create arr.make (2)
			arr.force (p)
			p := person_gustave_eiffel
			arr.force (p)

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
