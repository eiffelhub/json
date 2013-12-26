#!/bin/bash

echo "Compiling with gec"
GOBO_EIFFEL=ge gec --finalize --catcall=no ejson_test.ecf
