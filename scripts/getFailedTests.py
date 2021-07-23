RED   = "\033[1;31m"  
BLUE  = "\033[1;34m"
CYAN  = "\033[1;36m"
GREEN = "\033[0;32m"
RESET = "\033[0;0m"
BOLD    = "\033[;1m"
REVERSE = "\033[;7m"

import re
import sys
import os

sys.stdout.write(BLUE)
#path=sys.argv[1]
#print path

print "\nFailing Defects4J Tests"
patternDefects = re.compile("  - .*")

try:
    for i, line in enumerate(open('defects4j.out')):
        for match in re.finditer(patternDefects, line):
            defect = match.group()
            defect = defect.replace("  - ","")
            print defect
except:
    print "Failed to open defects4j.out"

sys.stdout.write(GREEN)

print "\nFailing Ba-dua Tests"
patternBadua = re.compile("\d*\).*\)")

try:
    for i, line in enumerate(open('ba-dua.out')):
        for match in re.finditer(patternBadua, line):
            defect = match.group()
            defect = defect.split(")")
            defect = defect[1].split("(")
            defect[0] = defect[0].replace(" ","")
            print defect[1]+"::"+defect[0]
except:
    print "Falied to open ba-dua.out"
    
sys.stdout.write(CYAN)

print "\nFailing Jaguar Tests"
patternJaguar = re.compile(".*INFO  JaguarDF - Test .*Failed")

try:
    for i, line in enumerate(open('jaguar.out')):
        for match in re.finditer(patternJaguar, line):
           defect = match.group()
           defect = defect.split("(")
           destcase  = defect[1].split(")")
           test = defect[0].split("- Test ")
           print testcase[0]+"::"+test[1]
except:
    print "Failed to open jaguar.out"

print "\n\n"

sys.stdout.write(RESET)
