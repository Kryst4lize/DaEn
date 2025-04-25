#! /bin/bash
# first four characters
echo "database" | cut -c1-4
# 5th to 8th characters
echo "database" | cut -c5-8
# 1st and 5th characters
echo "database" | cut -c1,5
# extracts usernames (the first field) from /etc/passwd
cut -d":" -f1 /etc/passwd
# extracts multiple fields 1st, 3rd, and 6th (username, userid, and home direct>
cut -d":" -f1,3,6 /etc/passwd
# range of fields 3rd to 6th (userid, groupid, user description and home direct>
cut -d":" -f3-6 /etc/passwd

# tr is a filter command used to translate, squeeze, and/or delete characters
# translates all lower case alphabets to upper case
echo "Shell Scripting" | tr "[a-z]" "[A-Z]"
echo "Shell Scripting" | tr "[:lower:]" "[:upper:]"
# translates all upper case alphabets to lower case
echo "Shell Scripting" | tr  "[A-Z]" "[a-z]"
# delete specified characters using the -d  option
echo "My login pin is 5634" | tr -d "[:digit:]"
# replaces repeat occurrences of ‘space’ in the output of ps command with one ‘space’.
ps | tr -s " "
