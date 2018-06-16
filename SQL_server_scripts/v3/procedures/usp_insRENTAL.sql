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
--obtain values
go

create procedure usp_insRENTAL_internal
	(
		@RenterID int,
		@EmployeeID int,
		@EqID int,
		@AuthorizerID int
	)
as
	insert into tblRENTAL (RenterID, EmployeeID, EqID, AuthorizerID)
		values (@RenterID, @EmployeeID, @EqID, @AuthorizerID)
	
