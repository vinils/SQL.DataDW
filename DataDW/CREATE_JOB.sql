USE [msdb]
GO

/****** Object:  Job [DataLoad]    Script Date: 13/04/2019 14:52:00 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 13/04/2019 14:52:00 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'DataLoad', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Load]    Script Date: 13/04/2019 14:52:00 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Load', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'---------------- FactDataLimit ---------------------------

insert into FactData
select 
SUBSTRING(FullName, 0, 400) as FullName, 
e.CollectionDate, 
gD.Name, 
gD.Initials, 
e.DecimalValue,
gD.MeasureUnit,
e.StringValue, 
case Discriminator 
	when ''DataDecimal'' then ld.Name
	when ''DataString'' then ls.Expected
end as LimitName,
case Discriminator 
	when ''DataString'' then ls.Expected
	when ''DataDecimal'' then 
	case
		when Max is null and Min is null then null
		when Max is null and Min is not null then 
			ld.Name + '' ( '' +
			case MinType 
				when 1 then ''> ''
				when 2 then ''>= ''
			End + 
			CONVERT(VARCHAR(50), Min) + '' )''
		when Max is not null and Min is null then 
			ld.Name + '' ( '' +
			case MaxType
				when 1 then ''< ''
				when 2 then ''<= ''
			End +
			CONVERT(VARCHAR(50), Max) + '' )''
		when Max is not null and Min is not null then 
			ld.Name + '' ( '' +
			case MinType 
				when 1 then ''> ''
				when 2 then ''>= ''
			End + 
			CONVERT(VARCHAR(50), Min) + '' e '' + 
			case MaxType
				when 1 then ''< ''
				when 2 then ''<= ''
			End +
			CONVERT(VARCHAR(50), Max) + '' )'' 
	end
end as LimitDescription,
case Discriminator 
	when ''DataDecimal'' then ld.Color
	when ''DataString'' then ls.Color
end as LimitColor,
e.Discriminator, 
CONVERT(char(4), YEAR(e.CollectionDate)) + FORMAT(e.CollectionDate,''MM'') + FORMAT(e.CollectionDate,''dd'') as DateKey
from [DataContextContext-20180321055800]..Data e
inner join [DataDW]..[DimGroup] g 
on e.GroupId = g.Id
inner join [DataContextContext-20180321055800]..[Group] gD
on gD.Id = g.Id and gD.ParentId = g.ParentId
left join [DataContextContext-20180321055800]..LimitDecimalDenormalized ld 
on e.GroupId = ld.GroupId and e.CollectionDate = ld.CollectionDate
left join [DataContextContext-20180321055800]..LimitStringDenormalized ls 
on e.GroupId = ls.GroupId and e.CollectionDate = ls.CollectionDate
where SUBSTRING(FullName, 0, 400) + CONVERT(VARCHAR, e.CollectionDate, 120) not in (select fD.FullName + CONVERT(VARCHAR, fD.CollectionDate, 120) from [DataDW]..[FactData] fD)

----------------------------------------------------------
---------------- FactDataLimit ---------------------------

insert into [DataDW]..FactDataLimit
select 
ISNULL(l.Id, ''92DBC513-4FBD-4FB7-AC64-B5AAAD07C77D'') as LimitId,
--l2.Description,
e.*
from [DataDW]..FactData e
left join [DataDW]..DimLimit l
on e.FullName = l.FullName and ((l.Min is not null and e.DecimalValue >= l.Min and e.DecimalValue < l.Max) or (l.Min is null and e.DecimalValue < l.Max))
where convert(nvarchar(50), ISNULL(l.Id, ''92DBC513-4FBD-4FB7-AC64-B5AAAD07C77D'')) + SUBSTRING(e.FullName, 0, 400) + CONVERT(VARCHAR, e.CollectionDate, 120) not in (select convert(nvarchar(50), fd.LimitId) + fD.FullName + CONVERT(VARCHAR, fD.CollectionDate, 120) from [DataDW]..[FactDataLimit] fD)

----------------------------------------------------------
---------------------- DimLimi ---------------------------

insert into DimLimit
select 
NEWID() as Id,
g.FullName,
l.Name,
case
	when min is null then CONCAT(l.Name, '' ( < '', Max, '' )'')
	when min is not null then CONCAT(l.Name, '' ( >= '', Min, '' e < '', Max, '' )'')
end as Description,
--''>='' as MinType,
Min,
--''<'' as MaxType,
Max,
Priority,
GroupId
from [DataContextContext-20180321055800]..LimitDecimal l
left join [DataDW]..DimGroup g
on l.GroupId = g.id
where convert(nvarchar(50), l.GroupId) + convert(nvarchar(50), l.[Max]) + convert(nvarchar(50), l.[Priority]) not in (select convert(nvarchar(50), l.GroupId) + convert(nvarchar(50), l.[Max]) + convert(nvarchar(50), l.[Priority]) from [DataDW]..DimLimit)

----------------------------------------------------------
', 
		@database_name=N'DataDW', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Daily', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=8, 
		@freq_subday_interval=6, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20190413, 
		@active_end_date=99991231, 
		@active_start_time=10000, 
		@active_end_time=235959, 
		@schedule_uid=N'10ed1c93-6661-4365-9201-07be78b421ab'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO


