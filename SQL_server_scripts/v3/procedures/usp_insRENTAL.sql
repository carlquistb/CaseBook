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

--Renter
declare @RenterID int
execute usp_getPERSONROLEID 
	@First = @RenterFName, 
	@Last = @RenterLName,
	@DOB = @RenterDOB,
	@Role = @RenterRoleName,
	@ID = @RenterID

--Authorizer
declare @AuthorizerID int
execute usp_getPERSONROLEID 
	@First = @AuthorizerFName, 
	@Last = @AuthorizerLName,
	@DOB = @AuthorizerDOB,
	@Role = @AuthorizerRoleName,
	@ID = @AuthorizerID 

--EQ
declare @EQID int
execute usp_getEQID 
	@Serial = @EqSerial, 
	@EqSubtype = @EqSubType, 
	@EqID = @EQID

--Employee
declare @EmployeeID int
execute usp_getPERSONROLEID 
	@First = @EmployeeFName, 
	@Last = @EmployeeLName,
	@DOB = @EmployeeDOB,
	@Role = @EmployeeRoleName,
	@ID = @EmployeeID

-- insert rental.
execute usp_insRENTAL_internal
	@RenterID = @RenterID,
	@EmployeeID = @EmployeeID,
	@EqID = @EQID,
	@AuthorizerID = @AuthorizerID

go