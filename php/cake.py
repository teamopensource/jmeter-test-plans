import sys
import glob
import argparse
import re
import os

parser = argparse.ArgumentParser(description='Convert cachegrind to csv')

parser.add_argument("--i", default=".", help="directory containing csv file")
parser.add_argument("--o", default=".", help="directory to generate result csv file")

args = parser.parse_args()

if args.o == ".":
	args.o = args.i

inname = args.i + "/all.csv"
keyname = args.i + "/keywords.csv"

distname = args.o + "/distinct.csv"
resultname = args.o + "/result.csv"

total_calls = 0
total_time = 0

methods = dict()

# summarize how many times a method has been called, 
# and how much time there has been spent in it totally
with open(inname, 'r') as infile:
	for row in infile:
		cols = row.split(",")
		method = cols[2] + " " + cols[3]
		time = int(cols[5])

		total_calls = total_calls + 1
		total_time = total_time + time

		if not method in methods:
			methods[method] = (1, time)
			#print "not in", method
		else:
			(calls, sum) = methods[method]
			methods[method] = (calls + 1, sum + time)
			#print "in", method, calls, time

# write out the summarization of the above
# (used to find keywords manually)
with open(distname, 'w') as distfile:
	for method in methods.keys():
		(calls, sum) = methods[method]
		distfile.write(",".join([method, str(calls), str(sum)]) + "\n")

keywords = dict()

# read the keywords that we need to summarize even more by
with open(keyname, 'r') as keyfile:
	for row in keyfile:
		keyword = row.strip()
		keywords[keyword] = (0, 0)

	keywords["other"] = (0, 0)

# summarize by keywords
for method in methods.keys():
	(calls, time) = methods[method]
	found = False
	
	for keyword in keywords.keys():
		keys = keyword.split(",")

		for key in keys:
			key = key.strip()

			if method.find(key) != -1:
				(c, t) = keywords[keyword]
				keywords[keyword] = (c + calls, t + time)

				found = True
				break
		if found:
			break
			
	if not found:
		(c, t) = keywords["other"]
		keywords["other"] = (c + calls, t + time)

# write the result
with open(resultname, 'w') as resultfile:
	for keyword in keywords.keys():
		(calls, time) = keywords[keyword]
		percent_calls = float(calls) / float(total_calls) * 100.0
		percent_time = float(time) / float(total_time) * 100.0

		resultfile.write(",".join(["\""+keyword+"\"", str(calls), str(total_calls), str(percent_calls), str(time), str(total_time), str(percent_time)]) + "\n")