USE [KnowYourTurf_DEV]
GO
/****** Object:  StoredProcedure [dbo].[TasksByField]    Script Date: 2/4/2013 8:05:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[TasksByField] 
	@FieldId int,
	@StartDate	DateTime,
	@EndDate	DateTime
AS
BEGIN
	SET NOCOUNT ON;
select t.ScheduledDate,
t.StartTime,
t.EndTime,
t.ActualTimeSpent,
t.Complete,
p.name as ProductName,
t.QuantityUsed
 from task as t left join InventoryProduct as ip on ip.entityid = t.InventoryProduct_id
 left join baseproduct as p on ip.Product_id = p.entityid
where t.field_id = @FieldId
		AND t.ScheduledDate >= @StartDate
		AND t.ScheduledDate <= @EndDate
END
