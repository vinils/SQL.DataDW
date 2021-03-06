/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -Q "TRUNCATE TABLE [DataContext].[dbo].[Data]"
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -Q "INSERT INTO [DataContext].[dbo].[Data] SELECT * FROM [$dataContextDb,1433].[DataContext].[dbo].[Data]"
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -Q "TRUNCATE TABLE [DataContext].[dbo].[Group]"
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -Q "INSERT INTO [DataContext].[dbo].[Group] SELECT * FROM [$dataContextDb,1433].[DataContext].[dbo].[Group]"
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -Q "TRUNCATE TABLE [DataContext].[dbo].[LimitDecimal]"
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -Q "INSERT INTO [DataContext].[dbo].[LimitDecimal] SELECT * FROM [$dataContextDb,1433].[DataContext].[dbo].[LimitDecimal]"
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -Q "TRUNCATE TABLE [DataContext].[dbo].[LimitDecimalDenormalized]"
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -Q "INSERT INTO [DataContext].[dbo].[LimitDecimalDenormalized] SELECT * FROM [$dataContextDb,1433].[DataContext].[dbo].[LimitDecimalDenormalized]"
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -Q "TRUNCATE TABLE [DataContext].[dbo].[LimitStringDenormalized]"
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -Q "INSERT INTO [DataContext].[dbo].[LimitStringDenormalized] SELECT * FROM [$dataContextDb,1433].[DataContext].[dbo].[LimitStringDenormalized]"
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P $SA_PASSWORD -Q "EXEC [DataDW].[dbo].[SP_Load]"