import re
import sys
import os

#path=sys.argv[1]
#print path

print "\nFailing jUNIT Tests"
patternJUnit = re.compile("^\d{1,2}\) .*\)")
jUnitDefects = []

try:
    for i, line in enumerate(open('junit.out')):
        for match in re.finditer(patternJUnit, line):
            defect = match.group()
            defect = defect.split(")")
            defect = defect[1].split("(")
            defect[0] = defect[0].replace(" ","")
            print defect[1]+"::"+defect[0]
            jUnitDefects.append(defect[1]+"::"+defect[0])
            jUnitDefects.sort()
except:
    print "Failed to open junit.out"

print "\nFailing Defects4J Tests"
patternDefects = re.compile("  - .*")
defects4jDefects = []

try:
    for i, line in enumerate(open('defects4j.out')):
        for match in re.finditer(patternDefects, line):
            defect = match.group()
            defect = defect.replace("  - ","")
            print defect
            defects4jDefects.append(defect)
            defects4jDefects.sort()
except:
    print "Failed to open defects4j.out"

print "\nFailing Ba-dua Tests"
patternBadua = re.compile("^\d{1,2}\) .*\)")
baduaDefects = []

try:
    for i, line in enumerate(open('ba-dua.out')):
        for match in re.finditer(patternBadua, line):
            defect = match.group()
            defect = defect.split(")")
            defect = defect[1].split("(")
            defect[0] = defect[0].replace(" ","")
            print defect[1]+"::"+defect[0]
            baduaDefects.append(defect[1]+"::"+defect[0])
            baduaDefects.sort()
except:
    print "Failed to open ba-dua.out"
    
print "\nFailing Jaguar Tests"
patternJaguar = re.compile(".*INFO  JaguarDF - Test .*Failed")
jaguarDefects = []

try:
    for i, line in enumerate(open('jaguar.out')):
        for match in re.finditer(patternJaguar, line):
           defect = match.group()
           defect = defect.split("(")
           testcase  = defect[1].split(")")
           test = defect[0].split("- Test ")
           print testcase[0]+"::"+test[1]
           jaguarDefects.append(testcase[0]+"::"+test[1])
           jaguarDefects.sort()
except:
    print "Failed to open jaguar.out"

print ("\n$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
if jUnitDefects == defects4jDefects:
    print ("jUnit OK")
else:
    print ("Inconsistencias no jUNIT")

if baduaDefects == defects4jDefects:
    print ("Ba-dua OK")
else:
    print ("Inconsistencias na Ba-dua")

if not jaguarDefects:
    print ("Dados da Jaguar nao Coletados ou Defeitos nao encontrados")
else:
    if jaguarDefects == defects4jDefects:
        print ("Jaguar OK")
    else:
        print ("Inconsistencias na Jaguar")
print ("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")

print "\n"
