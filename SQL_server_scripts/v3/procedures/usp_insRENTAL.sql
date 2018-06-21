create procedure usp_insRENTAL
	(
		@RenterFName nvarchar(50),
		@RenterLName nvarchar(50),
		@RenterDOB nvarchar(50),
		@RenterRoleName nvarchar(50),
		@AuthorizerFName nvarchar(50),
		@AuthorizerLName nvarchar(50),
		@AuthorizerDOB nvarchar(50),
		@AuthorizerRoleName nvarchar(50),
		@EqSerial int,
		@EqSubType nvarchar(50),
		@EmployeeFName nvarchar(50),
		@EmployeeLName nvarchar(50),
		@EmployeeDOB nvarchar(50),
		@EmployeeRoleName nvarchar(50)
	)
as

execute usp_getPERSON_ROLEID
--obtain values
go