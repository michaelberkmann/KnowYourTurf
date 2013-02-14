/****** Object:  StoredProcedure [dbo].[TaskReport]    Script Date: 2/13/2013 5:52:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[TaskReport] 
	@FieldId int,
	@StartDate	DateTime,
	@EndDate	DateTime,
	@ProductId	int,
	@EmployeeId	int,
	@TaskTypeId	int,
	@ClientId	int
AS
BEGIN
	SET NOCOUNT ON;
select 
t.EntityId,
f.Name,
tt.Name as TaskType,
t.ScheduledDate,
t.ActualTimeSpent,
p.name as ProductName,
t.QuantityUsed,
t.Notes,
@StartDate as StartDate,
@EndDate as EndDate,
STUFF((SELECT ', ' + em.FirstName +' '+ em.LastName 
	FROM [User] as em
		left join EmployeeToTask as emtt on em.entityid = emtt.User_id and emtt.Task_id = t.entityid 
		FOR XML PATH('')), 1, 1, '') as Employees
 from task as t left join InventoryProduct as ip on ip.entityid = t.InventoryProduct_id
 left join baseproduct as p on ip.Product_id = p.entityid
 left join Field as f on f.EntityId = t.Field_id
 left join TaskType as tt on t.TaskType_id = tt.EntityId
where t.ClientId = @ClientId
	  AND (@FieldId = 0 or t.field_id = @FieldId )
	  AND (@StartDate = CAST('1800-01-01' as Date) AND t.ScheduledDate = t.ScheduledDate
	  OR 
	  t.ScheduledDate >= @StartDate)
	  AND
	  (@EndDate = CAST('1800-01-01' as Date) AND t.ScheduledDate = t.ScheduledDate
	  OR 
	  t.ScheduledDate <= @EndDate)
	  AND
	  (@TaskTypeId = 0 or @TaskTypeId = t.TaskType_Id)
	  AND
	  (@ProductId = 0 or p.EntityId = @ProductId)
END
