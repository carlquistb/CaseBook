use CASEBOOK_V2_1
go

create procedure usp_insFACILITY_TYPE
	(
		@FacilityTypeName nvarchar(100),
		@FacilityTypeDescr nvarchar(500) = null
	)
as
	begin
	begin tran t1
	begin try
	INSERT INTO [dbo].[tblFACILITY_TYPE] 
		(FacilityTypeName,FacilityTypeDescr)
    VALUES
		(@FacilityTypeName,@FacilityTypeDescr)
	end try
	begin catch
		print 'Error: Insertion to the FacilityType table failed.'
		select ERROR_NUMBER() as 'error number', ERROR_MESSAGE() as 'error message', ERROR_PROCEDURE()  as 'sproc'
		rollback tran t1
	end catch
	end
GO

create procedure usp_insFACILITY
	(
		@FacilityName nvarchar(100),
		@FacilityDescr nvarchar(500) = null,
		@FacilityTypeID int
	)
as
	begin
	begin tran t1
	begin try
		INSERT INTO [dbo].[tblFACILITY]
				([FacilityName],[FacilityDescr],[FacilityTypeID])
		VALUES
			   (@FacilityName,@FacilityDescr,@FacilityTypeID)
		commit tran t1
	end try
	begin catch
		print 'Error: Insertion to the Facility table failed. Check the foreign key.'
		select ERROR_NUMBER() as 'error number', ERROR_MESSAGE() as 'error message', ERROR_PROCEDURE() as 'sproc'
		rollback tran t1
	end catch
	end
GO

create procedure usp_insTRANSMITTAL
	(
		@TransmittalName nvarchar(100),
		@TransmittalAmount money,
		@TransmittalDate datetime
	)
as
	begin
	begin tran t1
	begin try
		INSERT INTO [dbo].[tblTRANSMITTAL]
			(
				[TransmittalName],
				[TransmittalAmount],
				[TransmittalDate]
			)
		VALUES
			(
				@transmittalName,
				@TransmittalAmount,
				@TransmittalDate
			)
		commit tran t1
	end try
	begin catch
		print 'Error: Insertion into the Transmittal table failed.'
		select ERROR_NUMBER() as 'error number', ERROR_MESSAGE() as 'error message', ERROR_PROCEDURE() as 'sproc'
		rollback tran t1
	end catch
	end
GO

create procedure usp_insFEE_TYPE
	(
		@FeeTypeName nvarchar(100),
		@FeeTypeDescr nvarchar(500) = null
	)
as
	begin
	begin tran t1
	begin try
		INSERT INTO [dbo].[tblFEE_TYPE]
			(
				[FeeTypeName],
				[FeeTypeDescr]
			)
		 VALUES
			(
				@FeeTypeName,
				@FeeTypeDescr
			)
		commit tran t1
	end try
	begin catch
		print 'Error: Insertion into the FEE_TYPE table failed.'
		select ERROR_NUMBER() as 'error number', ERROR_MESSAGE() as 'error message', ERROR_PROCEDURE() as 'sproc'
		rollback tran t1
	end catch
	end
GO

create procedure usp_insFEE
	(
		@FeeName nvarchar(100),
		@FeeDescr nvarchar(500) = null,
		@FeeAmount money,
		@FeeTypeID int
	)
as
	begin
	begin transaction t1
	begin try
		INSERT INTO [dbo].[tblFEE]
			(
				[FeeName],
				[FeeDescr],
				[FeeAmount],
				[FeeTypeID]
			)
		VALUES
			(
				@FeeName,
				@FeeDescr,
				@FeeAmount,
				@FeeTypeID
			)
		commit transaction t1
	end try
	begin catch
		print 'Error: Insertion into the Fee table failed.'
		select ERROR_NUMBER() as 'error number', ERROR_MESSAGE() as 'error message', ERROR_PROCEDURE() as 'sproc'
		rollback transaction t1
	end catch
	end
go

create procedure usp_insEVENT_TYPE
	(
		@EventTypeName nvarchar(100),
		@EventTypeDescr nvarchar(500) = null
	)
as
	begin
	begin tran t1
	begin try
		insert into tblEVENT_TYPE
			(EventTypeName, EventTypeDescr)
		values
			(@EventTypeName, @EventTypeDescr)
		commit tran t1
	end try
	begin catch
		print 'Error: Insertion into the EventType table failed.'
		select ERROR_NUMBER() as 'error number', ERROR_MESSAGE() as 'error message', ERROR_PROCEDURE() as 'sproc'
		rollback tran t1
	end catch
	end
go

create procedure usp_insPERSON
	(
		@Fname nvarchar(100),
		@Lname nvarchar(100),
		@Mname nvarchar(100) = null,
		@DOB datetime,
		@Email nvarchar(100)
	)
as
	begin
	begin tran t1
	begin try
		insert into tblPERSON (Fname,LName, MName, DOB, Email)
		values (@Fname, @Lname, @Mname, @DOB, @Email)
		commit tran t1
	end try
	begin catch
		print 'Error: Insertion into the Person table failed.'
		select ERROR_NUMBER() as 'error number', ERROR_MESSAGE() as 'error message', ERROR_PROCEDURE() as 'sproc'
		rollback tran t1
	end catch
	end
go

create procedure usp_insROLE
	(
		@RollName nvarchar(100),
		@RollDescr nvarchar(500) = null,
		@RollDefaultDuration int
	)
as
	begin
	begin tran t1
	begin try
		insert into tblROLE (RoleName, RoleDescr, RoleDefaultDuration)
		values (@RollName, @RollDescr, @RollDefaultDuration)
		commit tran t1
	end try
	begin catch
		print 'Error: Insertion into the Role table failed.'
		select ERROR_NUMBER() as 'error number', ERROR_MESSAGE() as 'error message', ERROR_PROCEDURE() as 'sproc'
		rollback tran t1
	end catch
	end
go

create procedure usp_insPERSON_ROLE
	(
		@PersonID int,
		@RoleID int,
		@BeginDate date,
		@EndDate date
	)
as
	begin 
	begin tran t1
	begin try
		insert into tblPERSON_ROLE (PersonID, RoleID, BeginDate, EndDate)
		values (@PersonID, @RoleID, @BeginDate, @EndDate)
		commit tran t1
	end try
	begin catch
		print 'Error: Insertion into the PersonRole table failed.'
		select ERROR_NUMBER() as 'error number', ERROR_MESSAGE() as 'error message', ERROR_PROCEDURE() as 'sproc'
		rollback tran t1
	end catch
	end
go

create procedure usp_insEQUIPMENT_TYPE
	(
		@EQName nvarchar(100),
		@EQDescr nvarchar(500) = null
	)
as
	begin
	begin tran t1
	begin try
		insert into tblEQUIPMENT_TYPE (EquipmentTypeName, EquipmentTypeDescr)
		values (@EQName, @EQDescr)
		commit tran t1
	end try
	begin catch
		print 'Error: Insertion into EquipmentType table failed.'
		select ERROR_NUMBER() as 'error number', ERROR_MESSAGE() as 'error message', ERROR_PROCEDURE() as 'sproc'
		rollback tran t1
	end catch
	end
go

create procedure usp_insEQUIPMENT_SUBTYPE
	(
		@EQSName nvarchar(100),
		@EQSDescr nvarchar(500) = null,
		@EQTID int,
		@ReplaceCost money
	)
as
	begin
	begin tran t1
	begin try
		insert into tblEQUIPMENT_SUBTYPE (EquipmentSubtypeName, EquipmentSubtypeDescr, EquipmentTypeID, EquipmentReplacementCost)
		values (@EQSName, @EQSDescr, @EQTID, @ReplaceCost)
		commit tran t1
	end try
	begin catch
		print 'Error: Insertion into EquipmentSubtype table failed.'
		select ERROR_NUMBER() as 'error number', ERROR_MESSAGE() as 'error message', ERROR_PROCEDURE() as 'sproc'
		rollback tran t1
	end catch
	end
go

create procedure usp_insEQUIPMENT
	(
		@EquipmentName nvarchar(100),
		@EquipmentDescr nvarchar(500) = null,
		@EquipmentSubtype int
	)
as
	begin
	begin tran t1
	begin try
		insert into tblEQUIPMENT (EquipmentName, EquipmentDescr, EquipmentSubtypeID)
		values (@EquipmentName, @EquipmentDescr, @EquipmentSubtype)
		commit tran t1
	end try
	begin catch
		print 'Error: Insertion into the Equipment table failed.'
		select ERROR_NUMBER() as 'error number', ERROR_MESSAGE() as 'error message', ERROR_PROCEDURE() as 'sproc'
		rollback tran t1
	end catch
	end
go

create procedure usp_insEQUIPMENT_FACILITY
	(
		@EQID int,
		@FACID int
	)
as
	begin
	begin tran t1
	begin try
		insert into tblEQUIPMENT_FACILITY (EqID, FacID)
		values (@EQID, @FACID)
		commit tran t1
	end try
	begin catch
		print 'Error: Insertion into the EQUIPMENT_FACILITY table failed.'
		select ERROR_NUMBER() as 'error number', ERROR_MESSAGE() as 'error message', ERROR_PROCEDURE() as 'sproc'
		rollback tran t1
	end catch
	end
go

create procedure usp_insFEE_HISTORY
	(
		@FeeID int,
		@FeeAmount money,
		@FeeHistoryDate datetime
	)
as
	begin
	begin tran t1
	begin try
		insert into tblFEE_HISTORY (FeeID, FeeHistoryDate, FeeAmount)
		values (@FeeID, @FeeHistoryDate, @FeeAmount)
		commit tran t1
	end try
	begin catch
		print 'Error: Insertion into the FeeHistory table failed.'
		select ERROR_NUMBER() as 'error number', ERROR_MESSAGE() as 'error message', ERROR_PROCEDURE() as 'sproc'
		rollback tran t1
	end catch
	end
go

create procedure usp_insEVENT
	(
		@EventTypeID int,
		@EQID int,
		@FeeID int,
		@PersonRoleID int,
		@EventName nvarchar(100),
		@EventDate datetime
	)
as
	begin
	begin tran t1
	begin try
		insert into tblEVENT (EventName, EventDate, EventTypeID, EquipmentID, FeeID, P_R_ID)
		values (@EventName, @EventDate, @EventTypeID, @EQID, @FeeID, @PersonRoleID)
		commit tran t1
	end try
	begin catch
		print 'Error: Insertion into the Event table failed.'
		select ERROR_NUMBER() as 'error number', ERROR_MESSAGE() as 'error message', ERROR_PROCEDURE() as 'sproc'
		rollback tran t1
	end catch
	end
go

create procedure usp_insCOMMENT
	(	
		@CommentDate date,
		@EventID int,
		@CommentBody nvarchar(1000) = null
	)
as
	begin
	begin tran t1
	begin try
		insert into tblCOMMENT (CommentDate, EventID, CommentBody)
		values (@CommentDate, @EventID, @CommentBody)
		commit tran t1
	end try
	begin catch
		print 'Error: Insertion into the Comment table failed.'
		select ERROR_NUMBER() as 'error number', ERROR_MESSAGE() as 'error message', ERROR_PROCEDURE() as 'sproc'
		rollback tran t1
	end catch
	end
go