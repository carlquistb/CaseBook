alter procedure usp_getID_tblPERSON 
	@FName nvarchar(100), 
	@Lname nvarchar(100), 
	@DOB date, 
	@PersonID int output
as
	begin try
		begin tran t1
		set @PersonID = (select top 1 PersonID from tblPERSON where FName = @FName and LName = @Lname and DOB = @DOB)
		commit tran t1
	end try
	begin catch
		print 'error locating the Person entry with the specified parameters.'
		rollback tran t1
	end catch
go

alter procedure usp_getID_tblROLE
	@RoleName nvarchar(100),
	@RoleID int output
as
	begin try
		begin tran t1
		set @RoleID = (select top 1 RoleID from tblROLE where RoleName = @RoleName)
		commit tran t1
	end try
	begin catch
		print 'error locating the Role entry with the specified parameter.'
		rollback tran t1
	end catch
go

alter procedure usp_insPERSON_ROLE_with_params
	@BeginDate date,
	@EndDate date,
	@FName varchar(100),
	@LName varchar(100),
	@DOB date,
	@RoleName varchar(100)
as
	begin try
		begin tran t1
		declare @PersonID int
		execute usp_getID_tblPERSON @FName, @LName, @DOB, @PersonID=@PersonID output
		declare @RoleID int
		execute usp_getID_tblROLE @RoleName, @RoleID = @RoleID output
		print 'DEBUG: IDs have been set.'

		--create enddate using default date
		if(@EndDate is null)
		begin
			declare @defaultDuration int
			set @defaultDuration = (select top 1 RoleDefaultDuration from tblROLE where RoleID = @RoleID)
			set @EndDate = DATEADD(day,@defaultDuration,@BeginDate)
			--print 'default role duration was used. role end date was set as: ' + CAST(@EndDate AS nvarchar)
		end

		execute usp_insPERSON_ROLE @PersonID, @RoleID, @BeginDate, @EndDate
		commit tran t1
	end try
	begin catch
		print 'error in usp_insPERSON_ROLE procedure.'
		rollback tran t1
	end catch
go

create procedure usp_getID_tblEQUIPMENT_TYPE
	@TypeName nvarchar(100),
	@TypeID int output
as
	begin try
		begin tran t1
		set @typeID = (select top 1 EquipmentTypeID from tblEQUIPMENT_TYPE where EquipmentTypeName = @TypeName)
		commit tran t1
	end try
	begin catch
		print 'error in usp_getID_tblEQUIPMENT_TYPE.'
		rollback tran t1
	end catch
go
alter procedure usp_insEQUIPMENT_SUBTYPE_with_params
	@EQTypeName nvarchar(100),
	@EQSName nvarchar(100),
	@EQSDescr nvarchar(500),
	@ReplaceCost money
as
	begin try
		begin tran t1
		declare @EQTypeID int
		exec usp_getID_tblEQUIPMENT_TYPE @EQTypeName, @TypeID = @EQTypeID output
		exec usp_insEQUIPMENT_SUBTYPE @EQSName, @EQSDescr, @EQTypeID,@ReplaceCost
		commit tran t1
	end try
	begin catch
		print 'error in usp_insEQUIPMENT_SUBTYPE_with_params procedure.'
		rollback tran t1
	end catch
go

create procedure usp_getID_tblEQUIPMENT_SUBTYPE
	@STName nvarchar(100),
	@STID int output
as
	begin try
		begin tran t1
		set @STID = (select top 1 EquipmentSubtypeID from tblEQUIPMENT_SUBTYPE where EquipmentSubtypeName = @STName)
		commit tran t1
	end try
	begin catch
		print 'error: could not retrieve ID for equipment subtype with given name.'
		rollback tran t1
	end catch

go

alter procedure usp_insEQUIPMENT_with_params
	@EQSubtypeName nvarchar(100),
	@EQName nvarchar(100),
	@EQDescr nvarchar(500) = null
as
	begin try
		begin tran t1
		declare @EQSTypeID int
		exec usp_getID_tblEQUIPMENT_SUBTYPE @EQSubtypeName, @STID = @EQSTypeID output
		exec usp_insEQUIPMENT @EQName, @EQDescr, @EQSTypeID
		commit tran t1
	end try
	begin catch
		print 'error: usp_insEQUIPMENT_with_params procedure.'
		rollback tran t1
	end catch
go

create procedure usp_insCHECKOUT
	@EventID int,
	@expectedReturnDate date
as
	begin try
		begin tran t1
		insert into tblCHECKOUT (EventID, ExpectedReturnDate) values (@EventID, @expectedReturnDate)
		commit tran t1
	end try
	begin catch
		print 'Error: unable to insert into tblCHECKOUT.'
		rollback tran t1
	end catch
go

create procedure usp_getID_tblEVENT_TYPE
	@EventTypeName nvarchar(100),
	@EventTypeID int output
as
	begin try
		begin tran t1
		set @EventTypeID = (select EventTypeID from tblEVENT_TYPE where EventTypeName = @EventTypeName)
		commit tran t1
	end try
	begin catch
		print 'error: could not locate EventType with that name.'
		rollback tran t1
	end catch
go

create procedure usp_getID_tblFEE_TYPE
	@FeeTypeName nvarchar(100),
	@FeeTypeID int output
as
	begin try
		begin tran t1
		set @FeeTypeID = (select top 1 FeeTypeID from tblFEE_TYPE where FeeTypeName = @FeeTypeName)
		commit tran t1
	end try
	begin catch
		print 'error: unable to locate FEE_TYPE entry with that name.'
		rollback tran t1
	end catch
go

alter procedure usp_insFEE_with_params
	@FeeTypeName nvarchar(100),
	@FeeName nvarchar(100),
	@FeeDescr nvarchar(500),
	@FeeAmount money
as
	begin try
		begin tran t1
		declare @FeeTypeID int
		exec usp_getID_tblFEE_TYPE @FeeTypeName, @FeeTypeID = @FeeTypeID output
		exec usp_insFEE @FeeName, @FeeDescr, @FeeAmount, @FeeTypeID
		commit tran t1 
	end try
	begin catch
		print 'error: could not insert fee. usp_insFEE_with_params'
		rollback tran t1
	end catch
go

create procedure usp_getID_tblFEE
	@FeeName nvarchar(100),
	@FeeID int output
as
	begin try
		begin tran t1
		set @FeeID = (select top 1 FeeID from tblFEE where FeeName = @FeeName)
		commit tran t1
	end try
	begin catch
		print 'error: could not locate Fee entry with that name'
		rollback tran t1
	end catch
go

create procedure usp_getID_tblEQUIPMENT
	@EquipmentName nvarchar(100),
	@EquipmentSubtypeName nvarchar(100),
	@EQID int output
as
	begin try
		begin tran t1
		declare @STID int
		exec usp_getID_tblEQUIPMENT_SUBTYPE @EquipmentSubtypeName, @STID = @STID output
		set @EQID = (select top 1 EquipmentID from tblEQUIPMENT where EquipmentName = @EquipmentName and EquipmentSubtypeID = @STID)
		commit tran t1
	end try
	begin catch
		print 'unable to locate equipment ID.'
		rollback tran t1
	end catch
go

create procedure usp_getID_tblPERSON_ROLE
	@RoleName nvarchar(100),
	@FName nvarchar(100),
	@LName nvarchar(100),
	@DOB date,
	@P_R_ID int output
as
	begin try
		begin tran t1
		declare @PersonID int
		declare @RoleID int
		exec usp_getID_tblPERSON @FName, @LName, @DOB, @PersonID = @PersonID output
		exec usp_getID_tblROLE @RoleName, @RoleID = @RoleID output
		set @P_R_ID = (select top 1 P_R_ID from tblPERSON_ROLE where PersonID = @PersonID and RoleID = @RoleID order by BeginDate)
		commit tran t1
	end try
	begin catch
		print 'Error: unable to get the PersonRoleID.'
		rollback tran t1
	end catch
go

alter procedure usp_insPURCHASE
	@EQName nvarchar(100),
	@STName nvarchar(100),
	@RoleName nvarchar(100),
	@FName nvarchar(100),
	@LName nvarchar(100),
	@DOB date,
	@EventDate datetime = getdate
as
	begin try
		begin tran t1
		declare @EQID int
		exec usp_getID_tblEQUIPMENT @EQName, @STName, @EQID = @EQID output
		declare @P_R_ID int
		exec usp_getID_tblPERSON_ROLE @RoleName, @FName, @LName, @DOB, @P_R_ID = @P_R_ID output
		declare @FeeID int
		execute usp_getID_tblFEE 'purchase practice room key',@FeeID = @FeeID output
		declare @EventTypeID int
		execute usp_getID_tblEVENT_TYPE 'purchase', @EventTypeID = @EventTypeID output

		execute usp_insEVENT @EventTypeID,@EQID,@FeeID,@P_R_ID,'autogenerated:Purchase EVENT',@EventDate
		commit tran t1
	end try
	begin catch
		print 'unable to insert purchase event. Error thrown in usp_insPURCHASE.'
		rollback tran t1
	end catch
go
