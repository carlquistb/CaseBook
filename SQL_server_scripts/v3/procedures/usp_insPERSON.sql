alter procedure usp_insPERSON
	(
		@First nvarchar(50),
		@Last nvarchar(50),
		@DOB date,
		@Phone nvarchar(50) = null,
		@Email nvarchar(100)
	)
as
	--check if necessary info is there.
	if (@First is null or @Last is null or @Email is null or @DOB is null)
		begin
			print('not enough info to create a Person.')
			return
		end
	--check if person already exists.
	if exists (select * from tblPERSON where FName = @First and LName = @Last and DOB = @DOB)
		begin
			print ('this person already exists, or is not unique.')
			return
		end
	begin tran T1
	begin try
		insert into tblPERSON (Fname, LName, DOB, Phone, Email)
			values (@First, @Last, @DOB, @Phone, @Email)
	commit tran T1
	end try
	begin catch
	print ('error inserting into the tblPERSON table.')
	rollback tran T1
	end catch
go