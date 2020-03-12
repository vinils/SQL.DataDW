#!/bin/bash
/opt/mssql/bin/sqlservr &


# wait for MSSQL server to start
export STATUS=1
i=0

while [ $STATUS -ne 0 ] && [ $i -lt 60 ]; do
	i=$((i+1))
	/opt/mssql-tools/bin/sqlcmd -S localhost,1433 -U SA -P $SA_PASSWORD -Q 'SELECT 1;' >> /dev/null
	STATUS=$?
	sleep 1
done

if [ $STATUS -ne 0 ]; then 
	echo "Error: MSSQL SERVER took more than 60 seconds to start up."
	exit 1
fi

echo "======= MSSQL SERVER STARTED ========"

/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -i /DataAnalyze/DataContext/CREATE_DATABASE_DataContext_linux.sql
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -i /DataAnalyze/DataDW/CREATE_DATABASE_DataDW_linux.sql

/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -i /DataAnalyze/DataContext/CREATE_TABLE_Data.sql
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -i /DataAnalyze/DataContext/CREATE_TABLE_Group.sql
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -i /DataAnalyze/DataContext/CREATE_TABLE_LimitDecimal.sql
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -i /DataAnalyze/DataContext/CREATE_TABLE_LimitDecimalDenormalized.sql
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -i /DataAnalyze/DataContext/CREATE_TABLE_LimitStringDenormalized.sql


/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -i /DataAnalyze/DataDW/CREATE_TABLE_DimDate.sql
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -i /DataAnalyze/DataDW/CREATE_TABLE_DimGroup.sql
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -i /DataAnalyze/DataDW/CREATE_TABLE_DimLimit.sql
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -i /DataAnalyze/DataDW/CREATE_TABLE_FactDataLimit.sql
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -i /DataAnalyze/DataDW/CREATE_TABLE_FactData.sql
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -i /DataAnalyze/DataDW/CREATE_PROCEDURE_SP_DimDate.sql
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -i /DataAnalyze/DataDW/CREATE_PROCEDURE_SP_Load.sql
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -i /DataAnalyze/DataDW/CREATE_PROCEDURE_SP_Reload.sql

/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -Q "EXEC DataDW.[dbo].[SP_DimDate] @startdate='$start_date', @enddate='$end_date'"

/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -i /DataAnalyze/CREATE_JOB.sql

sleep infinity
