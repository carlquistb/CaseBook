ALTER procedure synthInsAuthorizer
	(@num int = 10)
as

	declare @PersonRoleID int
	declare @SubtypeID int
	declare @PersonFName nvarchar(50)
	declare @PersonLName nvarchar(50)
	declare @PersonDOB date
	declare @RoleName nvarchar(50)
	declare @subtypeName nvarchar(50)

	while(@num > 0)
	begin

		set @PersonRoleID = ceiling( rand() * (select count(*) from tblPERSON_ROLE) )
		set @SubtypeID = ceiling( rand() * (select count(*) from tblEQ_SUBTYPE) )

		set @PersonFName = (select FName from tblPERSON P join tblPERSON_ROLE PR on PR.PersonID = P.PersonID where PR.PersonRoleID = @PersonRoleID)
		set @PersonLName = (select LName from tblPERSON P join tblPERSON_ROLE PR on PR.PersonID = P.PersonID where PR.PersonRoleID = @PersonRoleID)
		set @PersonDOB = (select DOB from tblPERSON P join tblPERSON_ROLE PR on PR.PersonID = P.PersonID where PR.PersonRoleID = @PersonRoleID)

		set @RoleName = (select RoleName from tblROLE R join tblPERSON_ROLE PR on R.RoleID = PR.RoleID where PR.PersonRoleID = @PersonRoleID)

		set @subtypeName = (select ST.EqSubtypeName from tblEQ_SUBTYPE ST where ST.EqSubtypeID = @SubtypeID)
		execute usp_insAUTHORIZER 
			@PersonFName = @PersonFName, 
			@PersonLName = @PersonLName,
			@PersonDOB = @PersonDOB,
			@RoleName = @RoleName,
			@EQSubtypeName = @subtypeName

		set @num = @num - 1
	end
GO


