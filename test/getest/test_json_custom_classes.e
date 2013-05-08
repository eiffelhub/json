class TEST_JSON_CUSTOM_CLASSES

inherit
    SHARED_EJSON

    TS_TEST_CASE

create
    make_default

feature {NONE} -- Initialization

    make
            -- Create test object.
        do
        end

feature -- Test

    test_custom_classes
        local
            bc: BOOK_COLLECTION
            jbc: JSON_BOOK_CONVERTER
            jbcc: JSON_BOOK_COLLECTION_CONVERTER
            jac: JSON_AUTHOR_CONVERTER
            jo: JSON_OBJECT
            parser: JSON_PARSER
            jrep: STRING
        do
            Json.add_converter (create {JSON_UC_STRING_CONVERTER}.make)
            create jbc.make
            json.add_converter (jbc)
            create jbcc.make
            json.add_converter (jbcc)
            create jac.make
            json.add_converter (jac)
            jrep := "{%"name%":%"Test collection%",%"books%":[{%"title%":%"eJSON: The Definitive Guide%",%"isbn%":%"123123-413243%",%"author%":{%"name%":%"Foo Bar%"}}]}"
            create parser.make_parser (jrep)
            jo := Void
            jo ?= parser.parse
            assert ("jo /= Void", jo /= Void)
            bc := Void
            bc ?= json.object (jo, "BOOK_COLLECTION")
            assert ("bc /= Void", bc /= Void)
            jo ?= json.value (bc)
            assert ("jo /= Void", jo /= Void)
            assert ("JSON representation is correct", jo.representation.is_equal ("{%"name%":%"Test collection%",%"books%":[{%"title%":%"eJSON: The Definitive Guide%",%"isbn%":%"123123-413243%",%"author%":{%"name%":%"Foo Bar%"}}]}"))
        end

end -- class TEST_JSON_CUSTOM_CLASS
