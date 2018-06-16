create procedure usp_getROLEID
	(
		@RoleName nvarchar(50),
		@RoleID int output
	)
as
	set @RoleID = (select RoleID from tblROLE where RoleName = @RoleName)