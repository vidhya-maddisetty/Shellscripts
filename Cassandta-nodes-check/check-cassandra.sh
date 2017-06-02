#!/bin/bash
#===============================================================================
#
#          FILE:  check-cassandra.sh
# 
#         USAGE:  ./check-cassandra.sh 
# 
#   DESCRIPTION:  
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Vidhya Maddisetty
#       COMPANY:  
#       VERSION:  1.0
#       CREATED:  04/14/2017 12:39:33 PM UTC
#      REVISION:  ---
#=========================================================================

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

  echo " "  
  echo "############### Checking Cassandra Nodes In -> $element <- Environment ##############"
  echo " "
  echo "ENV:" $element
  echo "Cassandra Node IP:" ${array[$1]}
  echo " "
  echo "Note: Checking For Nodes Status(UP)"
  ssh -i ~/sanvan_nibiruv2.pem ubuntu@${array[$1]} nodetool status |grep UN
  echo " "
  echo "Note: Checking For Nodes Status(DOWN)"
  ssh -i ~/sanvan_nibiruv2.pem ubuntu@${array[$1]} nodetool status |grep DN
  echo " "
  echo "Note: Checking For Schema Syncronization"
  ssh -i ~/sanvan_nibiruv2.pem ubuntu@${array[$1]} nodetool describecluster |sed -n -e '/Schema versions/,$p'


 break
 fi
done

