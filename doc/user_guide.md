Preface
-------

This document is a living document! As always read and try out the code
to understand what's really going on.

### About the project

The eJSON project was started by Javier Velilla in 2008. The aim was
simply to provide JSON support to Eiffel programmers. A couple of other
people have been involved to various extent since the start; Berend de
Boer, Jocelyn Fiat and Manu Stapf. In 2009 Paul Cohen joined the project
as an active developer.

The current maintainers:
- Javier Velilla
- Jocelyn Fiat

The formal name of the project is “eJSON”.

For questions regarding eJSON please contact
- <javier.hector at gmail.com> 
- <jfiat at eiffel.com>
or directly on https://github.com/eiffelhub/json/issues

### Current version and status

The latest release is 0.6.0. eJSON has been improved and cleaned.
The converters are not obsolete.

Introduction
------------

### What is JSON?

JSON (JavaScript Object Notation) is a lightweight computer data
interchange format. It is a text-based, human-readable format for
representing simple data structures and associative arrays (called
objects). See the [Wikipedia article on JSON][], [www.json.org][] and
[www.json.com][] for more information.

The JSON format is specified in [IETF RFC 4627][] by Douglas Crockford.
The official [Internet MIME media type][] for JSON is
“application/json”. The recommended file name extension for JSON files
is ".json".

### Advantages

1. Lightweight data-interchange format. 
2. Easy for humans to read and write.
3. Enables easy integration with AJAX/JavaScript web applications. See the article [Speeding Up AJAX with JSON][] for a good short discussion on this subject. 
4. JSON data structures translate with ease into the native data structures universal to almost all programming languages used today.

### Use in Eiffel applications

JSON can be used as a general serialization format for Eiffel objects.
As such it could be used as a:

- Data representation format in REST-based web service applications written in Eiffel.
- Serialization format for Eiffel objects in persistence solutions.
- File format for configuration files in Eiffel systems.

### Prerequisites

eJSON works today with EiffelStudio 13.11
There is an optional extension that requires the latest snapshot of the Gobo Eiffel libraries (a working snapshot is distributed with EiffelStudio). The depencencies on Gobo are on Gobo's unicode
and regex libraries and for some of the extra features in eJSON, on Gobos structure classes DS_HASH_TABLE and DS_LINKED_LIST.

eJSON is intended to work with all ECMA compliant Eiffel compilers.

### Installation

You can either download a given release and install on your machine or you can get the latest snapshot of the code.
To download go to the [download page](http://ejson.origo.ethz.ch/download). 
To get the latest snapshot of the code do:

`   $ git clone https://github.com/eiffelhub/json.git json

*[download page](https://github.com/eiffelhub/json/releases): https://github.com/eiffelhub/json/releases
*[github project](https://github.com/eiffelhub/json): https://github.com/eiffelhub/json

Note that the latest json release is also delivered with EiffelStudio installation under $ISE_LIBRARY/contrib/library/text/parser/json.


Try pandoc!
from
to  

### Cluster and directory layout

`   json/`\
`     library/ (Root directory for eJSON library classes)`\
`       kernel/ (All classes in this cluster should eventually only depend on ECMA Eiffel and FreeELKS).`\
`         json_array.e`\
`         json_boolean.e`\
`         json_null.e`\
`         json_number.e`\
`         json_object.e`\
`         json_string.e`\
`         json_value.e`\
`       parser/`\
`         json_parser.e`\
`         json_parser_access.e`\
`         json_reader.e`\
`         json_tokens.e`\
`       utility/`\
`         file/`\
`            json_file_reader.e`\
`         visitor/`\
`           json_visitor.e`\
`           json_iterator.e`\
`           json_pretty_string_visitor.e`\
`           print_json_visitor.e`\
`       converters/ (JSON core converter classes !OBSOLETE!)`\
`         json_converter.e`\
`         json_hash_table_converter.e`\
`         json_list_converter.e`\
`         json_linked_list_converter.e`\
`         json_arrayed_list_converter.e`\
`         support/`\
`           ejson.e`\
`           shared_ejson.e`\
`       gobo_converters/ (JSON core converter classes support for GOBO !OBSOLETE!)`\
`         converters/`\
`           json_ds_hash_table_converter.e`\
`           json_ds_linked_list_converter.e`\
`         shared_gobo_ejson.e`\
`     test/ (Contains autotest suite)`\
`       autotest/ (AutoTest based unit test).`\
`     examples/ (Example code)`

### Future development

Here is a list of suggestions for future development of eJSON.
- Ongoing: Provide a JSON_FACTORY class for easy conversion between arbitrary JSON and Eiffel values.
- Ongoing: Provide a mechanism for users to add custom converters between JSON values and user space Eiffel classes.
- Ongoing: Implement a full test framework for eJSON.
- Suggestion: Investigate performance and improve it if necessary.
- Suggestion: Support JSON references. See [http://www.json.com/2007/10/19/json-referencing-proposal-and-library JSON Referencing Proposal and Library] and [http://www.sitepen.com/blog/2008/06/17/json-referencing-in-dojo JSON referencing in Dojo] for more information.
- Suggestion: Support JSON path. See [http://goessner.net/articles/JsonPath JSONPath - XPath for JSON]() for more information.
- Suggestion: Support JSON schema validation. See [http://json-schema.org JSON Schema Proposal] for more information.
- Suggestion: Support RDF JSON serialization. See [http://n2.talis.com/wiki/RDF_JSON_Specification RDF JSON Specification] for more information.
- Suggestion: Add support to JSON classes for conversion from Eiffel manifest values. So one can write things like:



  [Xebra]: http://dev.eiffel.com/Xebra_About
  [demo.taxosoft.org]: http://demo.taxosoft.org
  [Eiffel Twitter]: http://www.eiffelroom.com/library/eiffel_twitter
  [Wikipedia article on JSON]: http://en.wikipedia.org/wiki/JSON
  [www.json.org]: http://www.json.org
  [www.json.com]: http://www.json.com
  [IETF RFC 4627]: http://www.ietf.org/rfc/rfc4627.txt
  [Internet MIME media type]: http://www.iana.org/assignments/media-types
  [Speeding Up AJAX with JSON]: http://www.developer.com/lang/jscript/article.php/3596836

pandoc 1.13.1

© 2013–2014 John MacFarlane

