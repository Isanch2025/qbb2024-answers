#!/usr/bin/env python3

import sys

ourword = sys.argv[1]
my_file = open( sys.argv[2] )

for my_line in my_file: 
    if ourword in my_line:
        print( my_line )

my_file.close()