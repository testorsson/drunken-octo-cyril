#########################################################################################
#											#
#!/bin/bash										#
#											#
#########################################################################################
# Google "I'm feeling lucky" query builder for lynx.                     		#
# Last revision: elofturtle <jonatan@linux.com> 2013-08-01		 		#
#########################################################################################
# rawurlencode/rawurldecode from Orwellophile over at Stack Overflow:    		#
# http://stackoverflow.com/questions/296536/urlencode-from-a-bash-script 		#
#########################################################################################
									 		#
rawurlencode()								 		#
{									 		#
	local string="${1}"						 		#
	local strlen=${#string}						 		#
	local encoded=""						 		#
									 		#
	for (( pos = 0 ; pos < strlen ; pos++ )) ; do			 		#
		c=${string:$pos:1}					 		#
		case "$c" in						 		#
			[-_.~a-zA-Z0-9] ) o="${c}" ;;			 		#
			*) printf -v o '%%%02x' "'$c"			 		#
		esac							 		#
		encoded+="${o}"						 		#
	done								 		#
	echo "$encoded"							 		#
}									 		#
									 		#
									 		#
rawurldecode()								 		#
{									 		#
	printf -v REPLY '%b' "${1//%/\\x}"				 		#
}									 		#
									 		#
#########################################################################################
									 		#
# Below composes the search query:					 		#
									 		#
# 1st element separate, for getting the '+':es at the right place.	 		#
									 		#
q=$( rawurlencode "$1" )						 		#
									 		#
shift									 		#
									 		#
for  f; do								 		#
	q=$q+$( rawurlencode "$f" )		#a+b+c+d		 		#
done									 		#
									 		#
#########################################################################################
									 		#
# Below creates the lynx command script.						#
# Comment out this section and switch lynx command to the one without  "-cmd_script"	#
									 		#
tmpfile="${HOME}/.lynx-tmp-cmd-file"							#
											#
if [[ ! -f "$tmpfile" ]] ; then								#
	echo 'key <tab>' > "$tmpfile"							#
											#
	for (( i = 0 ; i < 15 ; i++ )) ; do						#
		echo 'key <tab>' >> "$tmpfile"						#
	done										#
# Uncomment if you want to automatically visit the topmost link.			#
# Else just position at said link.							#
#	echo 'key Right Arrow' >> "$tmpfile"						#
											#
fi											#
											#
# Execute Lynx - only one of the below should be uncommented!				#
											#
# This one moves the cursor to the topmost search result.				#
lynx http://www.google.com/search?q="$q" --accept_all_cookies -cmd_script="$tmpfile";	#
											#
# This one does not make use of the intermediary script file.				#
# Uncomment if you do not want to get to the topmost result.				#
# lynx http://www.google.com/search?q="$q" --accept_all_cookies -cmd_script="$tmpfile";	#
											#
# Uncomment if you want the script file to be generated each time.			#
# rm "$tmpfile"										#
#											#
#########################################################################################
