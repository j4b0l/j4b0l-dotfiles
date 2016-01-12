#!/usr/bin/env python

# Simple script to create a graph from docker-compose.yml file
# Only includes net links (dashed) and volume links (solid) for now

import sys
import yaml
from subprocess import Popen, PIPE, STDOUT

try:
    subject=sys.argv[1]
except IndexError:
    subject='docker-compose.yml'

try:
    result=sys.argv[2]
except IndexError:
    result='docker-compose.png'

resultType=result.split('.')[-1]
diagram=''

diagram+="\n"+ 'digraph dockercompose {'
with open(subject, 'r') as f:
    doc = yaml.load(f)
    for service in doc:
        diagram+="\n"+ '\"'+service+'\" [shape=box]'
        try:
            for vol_link in doc[service]['volumes_from']:
                target = vol_link
                diagram+="\n"+ '\"'+service+'\" -> \"'+target+'\";'
        except KeyError:
            pass
        try:
            for volume in doc[service]['volumes']:
                target = volume.split(':')[0]
                diagram+="\n"+ '\"'+target+'\" [shape=ellipse]'
                diagram+="\n"+ '\"'+service+'\" -> \"'+target+'\";'
                pass
        except KeyError:
            pass
        try:
            for net_link in doc[service]['links']:
                target = net_link.split(':')[0]
                diagram+="\n"+ '\"'+service+'\" -> \"'+target+'\" [style=dashed];'
        except KeyError:
            pass

diagram+="\n"+ '}'

p = Popen(['/usr/bin/dot','-T'+resultType, '-o'+result], stdout=PIPE, stdin=PIPE, stderr=PIPE)
p.communicate(input=diagram)[0]
