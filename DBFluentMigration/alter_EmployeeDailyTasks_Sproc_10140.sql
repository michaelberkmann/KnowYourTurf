/****** Object:  StoredProcedure [dbo].[EmployeeDailyTasks]    Script Date: 2/13/2013 3:16:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[EmployeeDailyTasks]
	@Date		DateTime,
	@ClientId	int
AS
BEGIN
	SET NOCOUNT ON;
select 
tt.Name as TaskType,
s.Name as SiteName,
f.Name as FieldName,
t.ScheduledDate,
t.StartTime,
t.EndTime,
p.name as ProductName,
t.QuantityNeeded,
t.UnitType,
u.firstname,
u.lastname,
u.EntityId as employeeId,
STUFF((SELECT ', ' + eq.Name 
	FROM Equipment as eq right join equipmenttotask as eqtt on eq.entityid = eqtt.equipment_id and eqtt.Task_id = t.entityid 
		FOR XML PATH('')), 1, 1, '') as Equipment
from [EmployeeToTask] as ett
 left join task as t on ett.Task_id = t.EntityId
 left join InventoryProduct as ip on ip.entityid = t.InventoryProduct_id
 left join baseproduct as p on ip.Product_id = p.entityid
 left join TaskType as tt on t.TaskType_id = tt.EntityId
 left join Field as f on t.Field_id = f.EntityId
 left join [Site] as s on f.Site_id = s.EntityId
 left join [user] as u on ett.User_id=u.EntityId
where   @Date = CAST(t.ScheduledDate as Date)
		AND t.ClientId = @ClientId
END
