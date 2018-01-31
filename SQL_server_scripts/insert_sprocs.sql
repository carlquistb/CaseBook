use CaseBook_v1

go

create procedure uspINSERT_EMAIL
	(
		@email_name nvarchar(100),
		@email_address nvarchar(500)
	)
as
	insert into tblEMAIL ([EMAIL_NAME], [EMAIL_ADDRESS]) values (@email_name, @email_address)
go

create procedure uspINSERT_PHONE
	(
		@phone_name nvarchar(100),
		@phone_number nvarchar(500)
	)
as
	insert into tblPHONE ([PHONE_NAME], [PHONE_NUMBER]) values (@phone_name, @phone_number)
go

create procedure uspINSERT_ADDRESS
	(
		@line_1 nvarchar(100),
		@line_2 nvarchar(100),
		@line_3 nvarchar(100),
		@city nvarchar(100),
		@state nvarchar(100),
		@zipcode nvarchar(100),
		@date date
	)
as
	insert into tblADDRESS ([LINE_1],[LINE_2],[LINE_3],[CITY],[STATE],[ZIPCODE],[DATE])
		values (@line_1, @line_2, @line_3, @city, @state, @zipcode, @date)
go

create procedure uspINSERT_TRANSMITTAL
	(
		@total_amount money,
		@date date,
		@number nvarchar(100),
		@note nvarchar(500)
	)
as
	insert into tblTRANSMITTAL ([TOTAL_AMOUNT],[DATE],[NUMBER],[NOTE])
		values (@total_amount, @date, @number, @note)
go

create procedure uspINSERT_PERSON
	(
		@f_name nvarchar(100),
		@m_name nvarchar(100),
		@l_name nvarchar(100),
		@dob date
	)
as
	insert into tblPERSON ([F_NAME],[M_NAME],[L_NAME],[DOB])
		values (@f_name, @m_name, @l_name, @dob)
go

create procedure uspINSERT_ROLE
	(
		@name nvarchar(100),
		@descr nvarchar(500),
		@term_length int,
		@key_1_cost money,
		@key_2_cost money,
		@key_3_cost money,
		@key_n_cost money
	)
as
	insert into tblROLE ([NAME],[DESC],[TERM_LENGTH],[KEY_1_COST],[KEY_2_COST],[KEY_3_COST],[KEY_N_COST])
		values (@name, @descr, @term_length, @key_1_cost, @key_2_cost, @key_3_cost, @key_n_cost)
go

create procedure uspINSERT_PERSON_ROLE
	(
		@person_id int,
		@role_id int,
		@start date,
		@end date,
		@exp date,
		@role_number nvarchar(100) 
	)
as
	insert into tblPERSON_ROLE ([PERSON_ID],[ROLE_ID],[START_DATE],[END_DATE],[EXP_END_DATE],[ROLE_ID_NUMBER])
		values (@person_id, @role_id, @start, @end, @exp, @role_number)
go

create procedure uspINSERT_ADDRESS_PERSON_ROLE
	(
		@prid int,
		@addid int
	)
as
	insert into tblADDRESS_PERSON_ROLE ([ADDRESS_ID],[PERSON_ROLE_ID]) values (@prid, @addid)
go

create procedure uspINSERT_EMAIL_PERSON_ROLE
	(
		@prid int,
		@email_id int
	)
as
	insert into tblEMAIL_PERSON_ROLE ([EMAIL_ID],[PERSON_ROLE_ID]) values (@prid, @email_id)
go

create procedure uspINSERT_PHONE_PERSON_ROLE
	(
		@prid int,
		@phone_id int
	)
as
	insert into tblPHONE_PERSON_ROLE ([PERSON_ROLE_ID],[PHONE_ID]) values (@prid, @phone_id)
go

create procedure uspINSERT_EQ_TYPE
	(
		@name nvarchar(100),
		@dtl int,
		@descr nvarchar(500)
	)
as
	insert into tblEQ_TYPE ([NAME],[DEFAULT_TERM_LENGTH],[descr])
		values (@name, @dtl, @descr)
go

create procedure usp_INSERT_EQ
	(
		@subtype_id int,
		@serial nvarchar(100)
	)
as
	insert into tblEQ ([EQ_SERIAL],[EQ_SUBTYPE_ID])
		values (@serial, @subtype_id)
go

create procedure uspINSERT_RENTAL
	(
		@user_id int,
		@emp_id int,
		@approver_id int,
		@eq_id int,
		@begin date,
		@end date,
		@exp date,
		@sig_file_path nvarchar(500)
	)
as
	begin tran T1
		begin try
			declare @use_id int
			insert into tblUSE ([USER_ID],[EMP_ID],[EQ_ID],[BEGIN_DATE],[SIG_FILE_PATH])
				values (@user_id, @emp_id, @eq_id, @begin, @sig_file_path)
			set @use_id = @@IDENTITY
			insert into tblRENTAL ([USE_ID],[APPROVER_ID],[END_DATE],[EXP_RETURN_DATE])
				values (@use_id, @approver_id, @end, @exp)
		end try
		begin catch
			rollback tran T1
			print 'ERROR: uspINSERT_RENTAL'
		end catch
	commit tran T1
go


create procedure uspINSERT_PURCHASE
	(
		@user_id int,
		@emp_id int,
		@eq_id int,
		@begin date,
		@sig_file_path nvarchar(500)
	)
as
	begin tran T1
		begin try
			declare @use_id int
			insert into tblUSE ([USER_ID],[EMP_ID],[EQ_ID],[BEGIN_DATE],[SIG_FILE_PATH])
				values (@user_id, @emp_id, @eq_id, @begin, @sig_file_path)
			set @use_id = @@IDENTITY
			insert into tblPURCHASE([USE_ID]) values (@use_id)
		end try
		begin catch
			rollback tran T1
			print 'ERROR: uspINSERT_PURCHASE'
		end catch
	commit tran T1
go

create procedure uspINSERT_NOTE
	(
		@use_id int,
		@writer_id int,
		@note nvarchar(500),
		@date date
	)
as
	insert into tblUSE_NOTE ([USE_ID],[WRITER_ID],[NOTE],[DATE])
		values(@use_id, @writer_id, @note, @date)
go

create procedure uspINSERT_CASH_MVNT
	(
		@use_id int,
		@transmittal_id int,
		@amount money
	)
as
	insert into tblCASH_MVNT ([USE_ID],[TRANSMITTAL_ID],[AMOUNT])
		values (@use_id, @transmittal_id, @amount)
go
