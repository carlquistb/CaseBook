alter procedure usp_getPERSONID
	(
		@First nvarchar(50),
		@Last nvarchar(50),
		@DOB date,
		@PersonID int output
	)
as
	--check if info was supplied
	if(@First is null or @Last is null or @DOB is null)
	begin
		print('not enough info was supplied to find a Person.')
		return
	end
	set @PersonID = (select top 1 PersonID from tblPERSON P where P.FName = @First and P.LName = @Last and DOB = @DOB)
go