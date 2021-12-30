#!/usr/bin/env python3

import os
import pandas as pd
import subprocess

df = pd.read_csv('kartenhalter.csv', dtype=str)


template = """use <../kartenhalter.scad>;
kartenhalter(%s);
"""

os.makedirs('scad', exist_ok=True)
for index, row in df.iterrows():
    file_name = 'scad/%s_x%s.scad' % (row['modul'], row['anzahl'])
    with open(file_name, 'w') as f:
        f.write(template % (row['anzahl']))

os.makedirs('stl', exist_ok=True)
bash_template = """openscad -o '%s' -D 'quality="production"' '%s'"""

for filename in os.listdir("./scad"):
    if filename.endswith(".scad"):
        name = os.path.splitext(filename)[0]
        directory = os.path.dirname(os.path.realpath(__file__))
        bashCommand = bash_template % (
            directory + "/stl/" + name + ".stl",
            directory + "/scad/" + name + ".scad"
        )
        print(bashCommand);
        continue
    else:
        continue
