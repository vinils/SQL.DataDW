# wait for MSSQL server to start
export STATUS=1
i=0

while [[ $STATUS -ne 0 ]] && [[ $i -lt 60 ]]; do
	i=$i+1
	/opt/mssql-tools/bin/sqlcmd -t 1 -S 127.0.0.1 -U sa -P $MSSQL_SA_PASSWORD -Q "select 1" >> /dev/null
	STATUS=$?
done

if [ $STATUS -ne 0 ]; then 
	echo "Error: MSSQL SERVER took more than 60 seconds to start up."
	exit 1
fi

echo "======= MSSQL SERVER STARTED ========" | tee -a ./config.log


# wait for database to start...
# echo "$0: SQL Server startup in progress"
# until sqlcmd -U SA -P ${SA_PASSWORD} -Q 'SELECT 1;' &> /dev/null; do
  # echo -n "."
  # sleep 1
# done


# /opt/mssql-tools/bin/sqlcmd

