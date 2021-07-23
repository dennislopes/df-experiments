import re
import sys
import os

#path=sys.argv[1]
#print path

print "\nFailing jUNIT Tests"
patternJUnit = re.compile("\d*\) test.*\)")

try:
    for i, line in enumerate(open('junit.out')):
        for match in re.finditer(patternJUnit, line):
            defect = match.group()
            defect = defect.split(")")
            defect = defect[1].split("(")
            defect[0] = defect[0].replace(" ","")
            print defect[1]+"::"+defect[0]
except:
    print "Failed to open junit.out"

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

print "\nFailing Ba-dua Tests"
patternBadua = re.compile("\d*\) test.*\)")

try:
    for i, line in enumerate(open('ba-dua.out')):
        for match in re.finditer(patternBadua, line):
            defect = match.group()
            defect = defect.split(")")
            defect = defect[1].split("(")
            defect[0] = defect[0].replace(" ","")
            print defect[1]+"::"+defect[0]
except:
    print "Failed to open ba-dua.out"
    
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

print "\n"
