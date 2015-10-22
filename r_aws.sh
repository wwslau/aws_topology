#!/bin/bash

rm -rf aws.csv
echo "Region,Resource-Type,Resource-ID,Key,Value,Key,Value,Key,Value,Key,Value" > aws.csv
firstMyResourceValue=""
osValue=""
while IFS='' read -r line || [[ -n "$line" ]]; do
    myResourceType=`echo "$line" | cut -f 2`
    myResourceValue=`echo "$line" | cut -f 3`
    myKey=`echo "$line" | cut -f 4`
    myValue=`echo "$line" | cut -f 5`
    echo "$myResourceType,$myResourceValue,$myKey,$myValue"
    if [ "$myResourceValue" != "$firstMyResourceValue" ]
	then
         if [ ! -z "$firstMyResourceValue" ]
	 then
         	if [ ! -z "$osValue" ]
	 	then
	 		echo -n ",os,$osValue" >> aws.csv
	 	fi
		echo "" >> aws.csv
	 fi
	 echo -n "$1,$myResourceType,$myResourceValue,$myKey,$myValue" >> aws.csv
	 firstMyResourceValue="$myResourceValue"
	 osValue=""
	else
	 if [ "$myKey" == "os" ]
	 then
	 	osValue="$myValue"
	 else
	 	echo -n ",$myKey,$myValue" >> aws.csv
	 fi

    fi
    if [ ! -z "$osValue" ]
 	then
		echo -n ",os,$osValue" >> aws.csv
    fi
done < aws.txt
