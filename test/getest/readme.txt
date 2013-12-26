Gobo ecf files
==============

To get the Gobo ecf files do as follows:

1. Create a directory for the custum Eiffel libraries

2. Define the environment variable EIFFEL_LIBRARY to point to the newly created directory

3. Clone the Git repository https://github.com/oligot/gobo-ecf in the newly created directory

EiffelStudio
============

To compile and run the test program using EiffelStudio do as follows:

1. Make sure you have a compiled version of getest in your PATH.

2. In this directory, run the command:

   $ getest --verbose ejson_test.cfg

Note: on Windows, you should use ejson_test-win.cfg

gec
===

To compile and run the test program using gec do as follows:

1. Make sure you have a compiled version of getest in your PATH.

2. In this directory, run the command:

   $ getest --verbose ejson_test.ge

Note: on Windows, you should use ejson_test-win.ge
