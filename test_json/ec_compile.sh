#!/bin/bash

echo "ec -finalize -c_compile -config test_json.ecf > /dev/null 2>&1"
ec -finalize -c_compile -config test_json.ecf > /dev/null 2>&1
cp EIFGENs/test_json/F_code/test_json .
