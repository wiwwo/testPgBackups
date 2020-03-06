#!/bin/bash
#set -x
#set -e

if [ $# -ne 1 ]
then
  echo "Please pass backup file name (.sql)"
  exit
fi

export whoAmI=`basename $0`
export backupToTest=$1
export tmpFileErrorlog=`/usr/bin/mktemp /tmp/$whoAmI.XXXXXXXXXXXXXXXXXX`
export tmpFileImport=`/usr/bin/mktemp /tmp/$whoAmI.XXXXXXXXXXXXXXXXXX`

cp -f $backupToTest $tmpFileImport

#echo "Testing import of file $1"...
USER=randomuser_does_not_exitst123 /usr/bin/pg_virtualenv >/dev/null 2> /dev/null << PGVIRTUALENV
USER=randomuser_does_not_exitst345 /usr/bin/psql < $tmpFileImport >/dev/null 2> $tmpFileErrorlog
PGVIRTUALENV
#echo "... done"

if [ -s "$tmpFileErrorlog" ]
then
  echo "Error file exists and not empty!!!"
  echo "Please check validity of backup file $1"
fi
rm -f $tmpFileImport
rm -f $tmpFileErrorlog
