
/****** Object:  StoredProcedure [dbo].[TasksByField]    Script Date: 2/5/2013 8:53:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[EmployeeDailyTasks]
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
u.EntityId as employeeId
from [EmployeeToTask] as ett
 left join task as t on ett.Task_id = t.EntityId
 left join InventoryProduct as ip on ip.entityid = t.InventoryProduct_id
 left join baseproduct as p on ip.Product_id = p.entityid
 left join TaskType as tt on t.TaskType_id = tt.EntityId
 left join Field as f on t.Field_id = f.EntityId
 left join [Site] as s on f.Site_id = s.EntityId
 left join [user] as u on ett.User_id=u.EntityId
where t.ScheduledDate = @Date
		AND t.CompanyId = @ClientId
END
