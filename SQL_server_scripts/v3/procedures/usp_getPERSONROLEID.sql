create procedure usp_getPERSONROLEID
	(
		@First nvarchar(50),
		@Last nvarchar(50),
		@DOB nvarchar(50),
		@Role nvarchar(50),
		@ID int output
	)
as

set @ID = (
	select PersonRoleID
	 from tblPERSON_ROLE PR 
		join tblPERSON P on P.PersonID = PR.PersonID 
		join tblROLE R on R.RoleID = PR.RoleID 
	where P.FName = @First 
		and P.LName = @Last 
		and P.DOB = @DOB 
		and R.RoleName = @Role
)