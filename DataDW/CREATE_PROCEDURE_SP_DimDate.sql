USE [DataDW]
-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_DimDate]
	-- Add the parameters for the stored procedure here
	@startdate date = '2005-01-01', 
	@enddate date = '2022-12-31'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--BEGIN TRAN 

	IF @startdate IS NULL
		BEGIN
			Select Top 1 @startdate = FulldateAlternateKey
			From DimDate 
			Order By DateKey ASC 
		END

	Declare @datelist table (FullDate date)

	while @startdate <= @enddate

	Begin 
		Insert into @datelist (FullDate)
		Select @startdate

		Set @startdate = dateadd(dd,1,@startdate)

	end 

	 Insert into dbo.DimDate 
		(DateKey, 
			FullDateAlternateKey, 
			DayNumberOfWeek, 
			EnglishDayNameOfWeek, 
			--SpanishDayNameOfWeek, 
			--FrenchDayNameOfWeek, 
			DayNumberOfMonth, 
			DayNumberOfYear, 
			WeekNumberOfYear, 
			EnglishMonthName, 
			--SpanishMonthName, 
			--FrenchMonthName, 
			MonthNumberOfYear, 
			CalendarQuarter, 
			CalendarYear, 
			CalendarSemester)
			--FiscalQuarter, 
			--FiscalYear, 
			--FiscalSemester)


	select convert(int,convert(varchar,dl.FullDate,112)) as DateKey,
		dl.FullDate,
		datepart(dw,dl.FullDate) as DayNumberOfWeek,
		left(datename(weekday,dl.FullDate), 3) as EnglishDayNameOfWeek,
		--(Select top 1 SpanishDayNameOfWeek From DimDate Where EnglishDayNameOfWeek = datename(weekday,dl.FullDate)) as SpanishDayNameOfWeek,
		--(Select top 1 FrenchDayNameOfWeek From DimDate Where EnglishDayNameOfWeek = datename(weekday,dl.FullDate)) as FrenchDayNameOfWeek,
		datepart(d,dl.FullDate) as DayNumberOfMonth,
		datepart(dy,dl.FullDate) as DayNumberOfYear,
		datepart(wk, dl.FUllDate) as WeekNumberOfYear,
		left(datename(MONTH,dl.FullDate), 3) as EnglishMonthName,
		--(Select top 1 SpanishMonthName From DimDate Where EnglishMonthName = datename(MONTH,dl.FullDate)) as SpanishMonthName,
		--(Select top 1 FrenchMonthName From DimDate Where EnglishMonthName = datename(MONTH,dl.FullDate)) as FrenchMonthName,
		Month(dl.FullDate) as MonthNumberOfYear,
		datepart(qq, dl.FullDate) as CalendarQuarter,
		year(dl.FullDate) as CalendarYear,
		case datepart(qq, dl.FullDate)
			when 1 then 1
			when 2 then 1
			when 3 then 2
			when 4 then 2
		end as CalendarSemester
		--case datepart(qq, dl.FullDate)
		--    when 1 then 3
		--    when 2 then 4
		--    when 3 then 1
		--    when 4 then 2
		--end as FiscalQuarter,
		--case datepart(qq, dl.FullDate)
		--    when 1 then year(dl.FullDate)
		--    when 2 then year(dl.FullDate)
		--    when 3 then year(dl.FullDate) + 1
		--    when 4 then year(dl.FullDate) + 1
		--end as FiscalYear,
		--case datepart(qq, dl.FullDate)
		--    when 1 then 2
		--    when 2 then 2
		--    when 3 then 1
		--    when 4 then 1
		--end as FiscalSemester

	from @datelist dl left join 
		DimDate dd 
			on dl.FullDate = dd.FullDateAlternateKey
	Where dd.FullDateAlternateKey is null 

	--COMMIT TRAN
END
GO
