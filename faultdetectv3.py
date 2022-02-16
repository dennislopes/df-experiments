#!/usr/bin/env python3

# To run this script you should first set up the environment for numpy
# Use the following commands:
# python3 -m venv work
# source work/bin/activate


# Directions to run the program
# parameters:

# 1: Jaguar data directory of the project: ../jaguar-data/<projectname>/<version>
# 2: Subsumption data directory of the project: ../subsumption-experiment/subsumption-data/<projectid>
# 3: Class name: name of the class whose data will be checked.

# Observations:
# Note that <projectid> != <projectname>. Use <projectid> and <projectname> as defined in the defects4j repository
# The json files should be in the  directory ../subsumption-data/<projectid>/reduce
# The matrix files should be in the directory ../jaguar-data/<projectname>/<version>/jaguar/.jaguar/matrix/

import numpy as np
import json
import os
#import progressbar
import sys
import xml.etree.ElementTree as ET
import re

def line_to_array(line):
	line = line[:-2].split()
	a = np.array(list(map(lambda x: int(x), line)))
	return a

def array_to_list(array):
	id = 0
	list = []
	while id < len(array):
		#print(d)
		if array[id] == 1:
			list.append(id)
		id = id + 1
	#print(list)
	return list

def create_array_zeros(size):
	a = np.zeros((int(size),),dtype=int)
	return a

def create_array_ones(size):
	a = np.ones((int(size),),dtype=int)
	return a

def set_elements_array(a,l):
	for i in l:
		a[i] = 1
	return a

def reset_elements_array(a,l):
	for i in l:
		a[i] = 0
	return a

def get_list_proj_classes_spectra(jaguar_spectra_folder_path):
	list_proj_classes = []
	for file in os.listdir(jaguar_spectra_folder_path):
		if file.endswith("spectra"):
			clazz = file.replace('.spectra','')
			list_proj_classes.append(clazz)
	return list_proj_classes

def get_list_proj_classes_matrix(jaguar_matrix_folder_path):
	list_proj_classes = []
	for file in os.listdir(jaguar_matrix_folder_path):
		if file.endswith("matrix"):
			clazz = file.replace('.matrix','')
			list_proj_classes.append(clazz)
	return list_proj_classes

# testcases is a dictionary with each test case's coverage string for which at least one dua was covered.
# testouputs is dictionary that mapps for each test case if it fails or passes. (may be unnecessary)
# failing_tests is a list of string with the number of tests that fails

def read_class_matrix_file(matrix_file,testcases,testouputs,no_class_duas):
	testcounter = 0
	failtests = 0
	no_duas_tests = 0
	failing_tests = []
	with open(matrix_file, "r") as f:
		for line in f:
			if line[-2] == '-':
				testouputs[testcounter] = True
				failtests = failtests + 1
				failing_tests.append(testcounter)
			else:
				testouputs[testcounter] = False

			if not line.startswith("=0"):
				testcases[testcounter] = line_to_array(line)
			else:
				testcases[testcounter] = create_array_zeros(no_class_duas)
			testcounter = testcounter + 1
	#print(testcases)
	return failing_tests

# dic_class will contain for each class' method the mapping for each leaf of subsumers the list of subsumed duas in string form.
# dic_class_array will contain for each class' method the mapping for each leaf of subsumers the list of subsumed duas in ndarray form.
# methods_name is a dictionary in which each element refers to one methods of the class. Note that there may be methods with the same name.
# methods_noDuas is a dictionary in which each element refers to the method's number of duas.

def read_class_subsumption_file(subsumption_file,dic_class,dic_class_arrays,methods_name,methods_noDuas):
	if os.path.exists(subsumption_file):
		with open(subsumption_file) as read_file:
			data = json.load(read_file)
			cl = data['Class']
			methods = data['Methods']
			counter = 0
			for m in methods:
				name = m['Name']
				noDuas = m['Duas']
				noSubsumers = m['Subsumers']
				itSubsumers = range(int(noSubsumers))

				dic_subsumption = {}
				dic_subsumption_array = {}
				for subsumer_key in itSubsumers:
						subsumers_list = m[str(subsumer_key)]
						subsumers_array = set_elements_array(create_array_zeros(noDuas),subsumers_list)

						subsuming_key = 'S'+str(subsumer_key)
						subsuming_list = m[subsuming_key]
						subsuming_array = set_elements_array(create_array_zeros(noDuas),subsuming_list)

						list_subsumption = []
						list_subsumption.append(subsumers_list)
						list_subsumption.append(subsuming_list)

						list_subsumption_array = []
						list_subsumption_array.append(subsumers_array)
						list_subsumption_array.append(subsuming_array)

						dic_subsumption[subsumer_key] = list_subsumption
						dic_subsumption_array[subsumer_key] = list_subsumption_array

				methods_name [counter] = name
				methods_noDuas[counter] = int(noDuas)
				dic_class[counter] = dic_subsumption
				dic_class_arrays[counter] = dic_subsumption_array
				counter = counter+1

	else:
		print('Could not open file '+subsumption_file)
	return

def get_class_subsumption_test_data(testcases,dic_methods_exec,dic_uncontrained_exec,dic_subsumed_exec,no_unconstrained_methods,wrong_subsumption_methods):

	for t in testcases:
		dic_method_uncontrained_exec = {}
		dic_method_subsumed_exec = {}
		testcase = testcases[t].copy()
		#print("Test %s: %s" %(t,testcase))
		start = 0

		for m in methods_noDuas:
			name = methods_name[m]
			offset = start + int(methods_noDuas[m])
			#print("%s:%s:%s:%s" % (methods_name[m], start,methods_noDuas[m],offset))
			testmethod = testcase[start:offset]
			start = offset

			if np.sum(testmethod,dtype=int) == 0:
				#print("No duas covered in %s." %name)
				continue
			else:
				if not name in dic_methods_exec:
					dic_methods_exec[name] = True # Method with duas was executed

			if len(dic_class_arrays[m]) == 0: # Method has no unconstrained duas; probability because SA could not find them
				dic_method_uncontrained_exec[m] = testmethod # uduas <= all duas executed
				dic_method_subsumed_exec[m] = testmethod # duas <= all duas executed
				#print("dic_method_uncontrained_exec[%s]:" % str(m))
				#print(dic_method_uncontrained_exec[m])
				#print("dic_method_subsumed_exec[%s]:" % str(m))
				#print(dic_method_subsumed_exec[m])
				if not m in no_unconstrained_methods:
					#print("No unconstrained duas in %s.%s.  uDUAs == all DUAs executed." %(clazz,name))
					no_unconstrained_methods.append(m)
				continue

			alluc = create_array_zeros(methods_noDuas[m]) # all unconstrained duas executed
			allu = create_array_zeros(methods_noDuas[m])

			exuc = create_array_ones(methods_noDuas[m])

			wrong_subsumption = False
			for leave in dic_class_arrays[m]:
	      		#print(dic_class_arrays[m][leave])
				u = dic_class_arrays[m][leave][0] # unconstrained duas in the leaf
				s = dic_class_arrays[m][leave][1] # subsumed duas by the leaf
				#print("test %s:%s" %(name,testmethod))
				uc = testmethod & u  # unconstrained duas in the leaf executed  by the test
	      		#print("uc %s" %uc)
				alluc |= uc # all unconstrained duas executed by the test
				exuc &= u # mutually exclusive unconstrained duas; exuc should be all zeros
				allu |= u # all unconstrained duas of the methods
				if 1 in uc: # test if there is an unconstrained dua covered by the test
					sc = testmethod & s # check which subsumed duas were covered by the test
					sc = np.bitwise_xor(s,sc) # all subsumed duas should have been covered
					if np.sum(sc,dtype=int) != 0: # sc should be all zeros
						#print("Wrong subsumption: %s" % name)
						#print("t:%s" % testmethod)
						#print("u:%s" % u)
						#print("s:%s" % s)
						wrong_subsumption = True
			#print("Method: %s" % name)
			#print("test string : %s" %testmethod)
			#print("alluc: %s" %alluc)

			if wrong_subsumption:
				if not m in wrong_subsumption_methods:
					#print("Wrong subsumption: %s.%s. uDUAs == uDUAs covered." % (clazz,name))
					wrong_subsumption_methods.append(m)

			dic_method_uncontrained_exec[m] = alluc
			dic_method_subsumed_exec[m] = testmethod

		#print("uduas in test %s: %s" % (name,t))
		#print(dic_method_uncontrained_exec)
		#print("duas in test %s: %s" % (name,t))
		#print(dic_method_subsumed_exec)

		dic_uncontrained_exec[t] = dic_method_uncontrained_exec
		dic_subsumed_exec[t] = dic_method_subsumed_exec

	return

def calculate_duas_coeficients(failing_tests_set,dic_exec):
	#print(dic_exec)

	dic_cef = {}
	dic_cnf = {}
	dic_cep = {}
	dic_cnp = {}
	#dic_fail_accumlator = {}
	dic_accumlator = {}
	dic_allones = {}
	#print(dic_exec)
	for m in methods_noDuas:
		noDuas = methods_noDuas[m]
		dic_cef[m] = create_array_zeros(noDuas)
		dic_cnf[m] = create_array_zeros(noDuas)
		dic_cep[m] = create_array_zeros(noDuas)
		dic_cnp[m] = create_array_zeros(noDuas)
		dic_accumlator[m] = create_array_zeros(noDuas)
		#dic_fail_accumlator[m] = create_array_zeros(noDuas)
		dic_allones[m] = create_array_ones(noDuas)

	for t in dic_exec:

		for m in methods_noDuas:
			#print("m:%s t:%s" %(m,t))

			if m in dic_exec[t]:
				testcase = dic_exec[t][m]
			else:
				testcase = create_array_zeros(methods_noDuas[m])

			isFailTest = False
			if t in failing_tests_set:
				isFailTest = True

			if isFailTest == True:
				#dic_fail_accumlator[m] = testcase + dic_fail_accumlator[m]
				dic_cef[m] = dic_cef[m] + testcase
				dic_cnf[m] = dic_cnf[m] + (dic_allones[m] ^ testcase)
			else:
				#dic_pass_accumlator[m] = testcase + dic_pass_accumlator[m]
				dic_cep[m] = dic_cep[m] + testcase
				dic_cnp[m] = dic_cnp[m] + (dic_allones[m] ^ testcase)
			dic_accumlator[m] = dic_cef[m] + dic_cnf[m] + dic_cep[m] + dic_cnp[m]
	coefs = {}
	coefs['cef'] = dic_cef
	coefs['cnf'] = dic_cnf
	coefs['cep'] = dic_cep
	coefs['cnp'] = dic_cnp
	#coefs['accf'] = dic_fail_accumlator
	coefs['acc'] = dic_accumlator
	#print(coefs)

	#dic_methods_coeficients[m] = coefs

	#print(dic_methods_coeficients)
	return coefs

def make_array_a_dict(arr):
	i = 0
	dic = {}
	for m in arr:
		dic[i] = arr[i]
		i = i + 1
	return dic

def create_sorted_dic(dic_of_arrays):
	dic_of_dics_sorted = {}
	for m in dic_of_arrays:
		dic_of_dics = make_array_a_dict(dic_of_arrays[m])
		dic_of_dics_sorted[m] = dict(sorted(dic_of_dics.items(), key = lambda kv: kv[1], reverse = True))
	return dic_of_dics_sorted

def sort_methods_by_value(dic):
	newDict = dict(sorted(dic.items(), key = lambda kv: (lambda x: x[list(x)[0]])(kv[1]), reverse = True))
	return newDict

def sort_classes_by_value(dic): # todo
	newDict = dict(sorted(dic.items(), key = lambda kv: (lambda y: y[list(y)[0]])((lambda x: x[list(x)[0]])(kv[1])), reverse = True))
	return newDict

def trim_value_dic(dic,value):
	#print(">>> Trimming <<<")
	for m in dic:
		#print(dic[m])
		newDict = dict(filter(lambda elem: elem[1] != value, dic[m].items()))
		#print(newDict)
		dic[m] = newDict
	return dic

def trim_empty_dic(dic):
	#print(">>> Trimming <<<")
	newDict = dict(filter(lambda elem: len(elem[1]) != 0, dic.items()))
	return newDict

def calculate_duas_fail_probability(dic_coefs):
	dic_fail_probability = {}
	for m in dic_coefs['cef']:  # here's the problem
		fail_probability = dic_coefs['cef'][m].copy();
		sum_cef_cep = dic_coefs['cef'][m].copy() + dic_coefs['cep'][m].copy()
		#print("%s:%s:cef %s: cef+cep %s" %(m,methods_name[m],fail_probability,sum_cef_cep))
		#print("%s:%s:cef %s: cef+cep %s" %(m,methods_name[m],fail_probability,sum_cef_cep))
		fail_probability = np.divide(fail_probability,np.where(sum_cef_cep !=0,sum_cef_cep,1))
		#print("fail prob:%s" % fail_probability)
		dic_fail_probability[m] = fail_probability
	return dic_fail_probability

def calculate_duas_ochiai(dic_coefs):
	dic_ochiai = {}
	for m in dic_coefs['cef']:  # here's the problem

		num_ochiai = dic_coefs['cef'][m].copy();
		sum_cef_cep = dic_coefs['cef'][m].copy() + dic_coefs['cep'][m].copy()
		sum_cef_cnf = dic_coefs['cef'][m].copy() + dic_coefs['cnf'][m].copy()
		mult_sums = np.multiply(sum_cef_cnf,sum_cef_cep)
		denom_ochiai = np.sqrt(np.where(mult_sums!=0,mult_sums,1))
		#print("%s:%s:cef %s: cef+cep %s" %(m,methods_name[m],fail_probability,sum_cef_cep))
		ochiai = np.divide(num_ochiai,denom_ochiai)
		#print("fail prob:%s" % fail_probability)
		#print(methods_name[m])
		#print("num_ochiai: %s" % num_ochiai)
		#print("sum_cef_cep: %s" % sum_cef_cep)
		#print("sum_cef_cnf: %s" % sum_cef_cnf)
		#print("mult_sums: %s" % mult_sums)
		#print("denom_ochiai: %s" % denom_ochiai)
		#print("ochiai: %s" % ochiai)
		dic_ochiai[m] = ochiai
	return dic_ochiai

if __name__ == '__main__':
	#project_name = sys.argv[1]
	#version_name = sys.argv[2]

#Parameter 1: /Users/marcoschaim/experimentos/subsumption-experiment/jaguar-data-extended/commons-math/1b
#Parameter 2: /Users/marcoschaim/experimentos/subsumption-experiment/subsumption-data/Math
#Parameter 3: 1b (version)
#Parameter 4: -ochiai/-faultdetect
#Parameter 5: -uduas/-duas (unconstrained duas or regular duas)
#Parameter 6: -all/ -class
#Parameter 7: name of the class if the option was -class

	print("Number of parameters: %s" % len(sys.argv))
	if len(sys.argv) < 6 or (sys.argv[4] != "-ochiai" and sys.argv[4] != "-faultdetect") or (sys.argv[5] != "-uduas" and sys.argv[5] != "-duas"):
		print("Wrong parameters:")
		print("arg[1]: jaguar data directory")
		print("arg[2]: subsumption data directory")
		print("arg[3]: faulty version (e.g., 1b)")
		print("arg[4]: -ochiai/-faultdetect (ochiai or fault detection probability ranking)")
		print("arg[5]: -uduas/-duas (unconstrained or regular duas)")
		print("arg[6]: -all/-class (all classes or a particular class)")
		print("arg[7]: class name (optional; due if -class is arg[6])")
		print("arg[8]: -csv (optional; indicates to save the results as a csv file)")
		print("arg[9]: <csv file name> (optional; due if -cvs is arg[8])")
		sys.exit(1)

	jaguar_dir = sys.argv[1]
	subsumption_dir = sys.argv[2]
	version = sys.argv[3]
	info = sys.argv[4]
	duatype = sys.argv[5]

	print("Directory of jaguar data: %s" % jaguar_dir)
	print("Directory of subsumption data: %s" % subsumption_dir)


	clazz = sys.argv[6]

	classlist = []
	if clazz == "-all":
		# classlist = get_list_proj_classes_spectra(os.path.join(jaguar_dir, "jaguar", ".jaguar", "spectra"))
		classlist = get_list_proj_classes_matrix(os.path.join(jaguar_dir, "jaguar", ".jaguar", "matrix"))
		if len(sys.argv) > 7:
			csvoption = sys.argv[7]
			csvfile = sys.argv[8]
			#print(csvoption)
			#print(csvfile)
		else:
			csvoption = ""
	else:
		if clazz == "-relevant":
			print("To do: treat relevant classes file")
			sys.exit(0)
		else:
			if clazz == "-class":
				clazz = sys.argv[7]
				classlist.append(clazz)
			else:
				print("Wrong parameters")
				sys.exit(0)
		if len(sys.argv) > 9:
			csvoption = sys.argv[9]
			csvfile = sys.argv[10]
		else:
			csvoption = ""

	if csvoption != "":
		print("csvoption: "+csvoption)
		print("csvfile: "+ csvfile)
	else:
		print("No csvoption")
		csvoption=""

	#print("Class list: %s" % classlist)

	dic_class_rank = {}
	dic_duas_rank = {}
	for clazz in classlist:
		total = None
		print("Analyzing class %s" % clazz, end = "\n")

		subsumption_folder = os.path.join(subsumption_dir, "reduce", version)
		subsumption_file = subsumption_folder + '/' + clazz + ".sub.json"
		dua_file = subsumption_folder + '/' + clazz + ".duas.json"
		#print(subsumption_file)

		dic_class = {}
		dic_class_arrays = {}
		methods_name = {}
		methods_noDuas = {}

		read_class_subsumption_file(subsumption_file,dic_class,dic_class_arrays,methods_name,methods_noDuas)

		# Calculate the class' number of duas
		no_class_duas = 0
		for m in methods_noDuas:
			no_class_duas = no_class_duas + methods_noDuas[m]

		if no_class_duas == 0:
			print("Class %s has no DUAs." % clazz)
			continue

		matrix_folder = os.path.join(jaguar_dir, "jaguar", ".jaguar", "matrix")
		matrix_file = matrix_folder + "/" + clazz + ".matrix"

		testcases = {}
		testouputs = {}
		no_duas_tests = 0

		failing_tests_set = read_class_matrix_file(matrix_file,testcases,testouputs,no_class_duas)
		failtests = len(failing_tests_set)

		testcounter = len(testcases)

		# test to verify if the number of duas (columns) of the matrix file is equat to
		# the number of duas of the class.

		matrix_no_duas = len(testcases[0])

		if matrix_no_duas != no_class_duas:
			print("Warning: Class %s number of DUAs (%s) is different from matrix number of columns (%s)." %(clazz,no_class_duas,matrix_no_duas))

		dic_uncontrained_exec = {}
		dic_methods_exec = {}
		dic_duas_exec = {}
		no_unconstrained_duas_methods = []
		wrong_subsumption_methods = []

		get_class_subsumption_test_data(testcases,dic_methods_exec,dic_uncontrained_exec,dic_duas_exec,no_unconstrained_duas_methods,wrong_subsumption_methods)

		#print("dic_uncontrained_exec")
		#print(dic_uncontrained_exec)

		#print("dic_duas_exec")
		#print(dic_duas_exec)


		#print("Class:%s:" % clazz)
		#print("Failing tests: %s; total tests %s" % (failtests,testcounter))
		#print("No of Methods executed: %s" % (len(dic_methods_exec)))
		#print(dic_methods_exec)

		#print("%s fail tests for class: %s:" % (failtests, clazz))

		#print("Fail tests: %s" %failing_tests_set)

		touches_bug = False
		touching_tests = []

		for t in failing_tests_set:
			if t in dic_uncontrained_exec:
				touches_bug = True
				touching_tests.append(t)

		if touches_bug == False:
			print("Class %s does not touch bug" % clazz)
			continue
		#else:
		#	print("Class %s touches bug by failing tests: %s" % (clazz,touching_tests))
			#	for t in dic_uncontrained_exec:
			#		for m in dic_uncontrained_exec[t]:
			#			name = methods_name[m]
			#			testmethod_unconstrained = dic_uncontrained_exec[t][m]
			#			print("test %s : method : %s: %s" %(t, name,testmethod_unconstrained))


		#print('unconstrained duas coeficients:')
		#print(methods_coefs)

		#dic_rank = calculate_duas_fail_probability(methods_coefs)

		if duatype == "-uduas":
			methods_coefs = calculate_duas_coeficients(failing_tests_set,dic_uncontrained_exec)
			#print(methods_coefs)
			if info == "-ochiai":
				dic_rank = calculate_duas_ochiai(methods_coefs)
			else:
				dic_rank = calculate_duas_fail_probability(methods_coefs)
		else:
			methods_coefs = calculate_duas_coeficients(failing_tests_set,dic_duas_exec)
			#print(methods_coefs)
			if info == "-ochiai":
				dic_rank = calculate_duas_ochiai(methods_coefs)
			else:
				dic_rank = calculate_duas_fail_probability(methods_coefs)

		#print(dic_rank)

		dic_rank_sorted = create_sorted_dic(dic_rank)
		dic_rank_sorted = trim_value_dic(dic_rank_sorted,0)
		dic_rank_sorted = trim_empty_dic(dic_rank_sorted)

		#print(dic_rank_sorted)

		#print("sort_methods_by_value")
		dic_rank_sorted = sort_methods_by_value(dic_rank_sorted)

		#print(dic_rank_sorted)
		dic_class_rank [clazz] = dic_rank_sorted

		if os.path.exists(dua_file):
			with open(dua_file) as read_file:
				data = json.load(read_file)

		if os.path.exists(subsumption_file):
			with open(subsumption_file) as read_file:
				sub_data = json.load(read_file)

		for m in dic_rank_sorted:
			method_info = data['Methods'][m]
			method_sub_info = sub_data['Methods'][m]

			noSubsumers = method_sub_info['Subsumers']
			itSubsumers = range(int(noSubsumers))

			method_status = "clear"

			if m in wrong_subsumption_methods:
				method_status = "wrong"
				#print("wrong subsumption")

			if m in no_unconstrained_duas_methods:
				method_status = "nounc"
				#print("no_unconstrained_dua")

			for dua in dic_rank_sorted[m]:
				#print(methods_name[m])
				dua_info = method_info[str(dua)]
				dua_data = []

				dua_desc = clazz+"%"+methods_name[m]+"#"+str(m)+"@"+str(dua)+"$"+dua_info
				dua_data.append(dic_rank_sorted[m][dua])
				uncons = False
				for subsumer_key in itSubsumers:
					subsumers_list = method_sub_info[str(subsumer_key)]
					dualeave = -1

					if dua in subsumers_list:
						dualeave = subsumer_key
						uncons = True
						break

				dua_data.append(uncons)
				#dua_data.append(dualeave)
				dua_data.append(method_status)
				dic_duas_rank[dua_desc] = dua_data
		#print(dic_duas_rank)
		clearclazzname = " "*len(clazz)
		print("Analyzing class %s" % clearclazzname, end = "\n")
	#dic_class_rank = sort_classes_by_value(dic_class_rank)


	if duatype == "-uduas":
		duatype = "Unconstrained DUAs"
	else:
		duatype = "DUAs"

	if info == "-ochiai":
		info = "OCHIAI   \t"
	else:
		info = "FAULT DETECTION "

	if csvoption != "-csv":
		dic_duas_rank = sorted(dic_duas_rank.items(), key=lambda item: item[1][0], reverse=False)

		print ("=========================================================")
		print (info +"Uncon\t"+"Status\t"+ duatype + " Version " + version)
		print ("=========================================================")

		float_formatter = "{:.6f}".format
		for dua in dic_duas_rank:
			print(float_formatter(dua[1][0])+"\t"+str(dua[1][1])+"\t"+dua[1][2]+"\t"+dua[0])

		print ("=========================================================")
		print (info + duatype + " Version " + version)
		print ("=========================================================")
	else:
		dic_duas_rank = sorted(dic_duas_rank.items(), key=lambda item: item[1][0], reverse=True)
		float_formatter = "{:.6f}".format
		with open(csvfile,"w") as outcsvfile:
			outcsvfile.write (info + ";" + "Uncon;" + "Status;" + duatype + "; Version;" + version+"\n")
			for dua in dic_duas_rank:
				#print(float_formatter((dua[1][0]))+";"+str(dua[1][1])+";"+dua[1][2]+";"+dua[0]+"\n")
				outcsvfile.write(float_formatter(dua[1][0])+";"+str(dua[1][1])+";"+dua[1][2]+";"+dua[0]+"\n")
		outcsvfile.close()
		jsonfile = csvfile.replace('.csv','')
		jsonfile = jsonfile+'.json'
		with open(jsonfile, 'w') as jf:
			json.dump(dic_duas_rank, jf,  indent=4)
