create procedure usp_insPERSON_ROLE
	(
		@First nvarchar(50),
		@Last nvarchar(50),
		@DOB date,
		@RoleName nvarchar(50),
		@Begin date,
		@expend date,
		@roleRef nvarchar(50) = null,
		@end date = null
	)
as

--check if enough Person_Role info was given.
if (@Begin is null or @expend is null)
	begin
		print('not enough person_role info provided.')
		return
	end

--check if enough info was supplied for a person.
if (@First is null or @Last is null or @DOB is null)
	begin
		print('not enough info to find the Person.')
		return
	end

--find the person.
declare @PersonID int
execute usp_getPERSONID
	@PersonID = @PersonID output,
	@First = @First,
	@Last = @Last,
	@DOB = @DOB

--check if role is null
if (@RoleName is null)
	begin
	print('no role name was supplied. Will create a person without a role.')
	end

--get the role.
declare @RoleID int
execute usp_getROLEID
	@RoleName = @RoleName,
	@RoleID = @RoleID output

--create the Person_Role.
begin tran T1
begin try
	insert into tblPERSON_ROLE (PersonID, RoleID, BeginDate, ExpEndDate, EndDate, RoleRef)
		values (@PersonID, @RoleID, @Begin, @expend, @end, @roleRef)
commit tran T1
end try
begin catch
	print('insertion error: usp_insPERSON_ROLE')
rollback tran T1
end catch