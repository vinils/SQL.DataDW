do { 
	$count = $count + 1; 
	$healfcheck = (sqlcmd -S localhost,1433 -i .\DataContext\CREATE_DATABASE_DataContext.sql); 
	Start-Sleep -Seconds 10 
} while(!$healfcheck -and $count -ne 60) ;