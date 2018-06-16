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