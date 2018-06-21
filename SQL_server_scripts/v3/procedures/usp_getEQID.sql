create procedure usp_getEQID
	(
		@Serial int,
		@EqSubtype int,
		@EqID int output
	)
as
	set @EqID = (select EqID from tblEQ where Serial = @Serial and EqSubtypeID = @EqSubtype)