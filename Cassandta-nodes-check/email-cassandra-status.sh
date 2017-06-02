#!/bin/bash
#===============================================================================
#
#          FILE:  email-cassandra-status.sh
# 
#         USAGE:  ./email-cassandra-status.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  vidya
#       COMPANY:  
#       VERSION:  1.0
#       CREATED:  05/09/2017 07:00:08 AM UTC
#      REVISION:  ---
#==============================================================================

declare -A array
#Cassandra nodes for all environments

array[prod]=10.198.4.215
array[ppe]=10.199.10.132
array[qa]=10.199.242.63
array[qab]=10.199.248.167
array[stg]=10.199.11.20
array[stgb]=10.199.12.98

for element in "${!array[@]}"; do
if [[ $element == $1 ]]; then
ssh -i ~/sanvan_nibiruv2.pem ubuntu@${array[$1]} nodetool status |grep DN > /tmp/test.txt
if [ -s "/tmp/test.txt" ] 
then
	echo emaill
        # do something as file has data
else
break;
fi 
break;
fi

ssh -i ~/sanvan_nibiruv2.pem ubuntu@${array[$1]} nodetool describecluster |sed -n -e '/Schema versions/,$p' > /tmp/schema-test.txt
x=$(wc -l </tmp/schema-test.txt)
if [ $x -gt 3 ]
then
 echo email
 break;
else
break;
fi
done


