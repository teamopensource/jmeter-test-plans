import sys
import re
import random

fullnames = []
passwords = []
usernames = []
coursename = "mytestcourse"

f_in = open("200fullnames", "r")
for line in f_in:
	match_n = re.search("^(\w+\s\w+)", line)
	if (match_n != None):
		fullnames.append(match_n.group(1))

n = len(fullnames)

f_in = open("passwords", "r")
i = 0
for line in f_in:
	passwords.append(line.rstrip('\r\n'))
	if (i > n):
		break

print("username,password,firstname,lastname,email,course1")
for fn in fullnames:
	parts = fn.split(' ')
	first = parts[0]
	last = parts[1]

	# Find initals
	user = None
	lnc = 2
	while(user == None):
		tryusername = "{0}{1}".format(first[:2], last[:lnc]).lower()
		if(not tryusername in usernames):
			user = tryusername
			usernames.append(user)
		lnc = lnc + 1

	email = user + "@ftu.dk"
	password = passwords[random.randint(0, n)]

	print("{0},{1},{2},{3},{4},{5}".format(user,password,first,last,email,coursename))