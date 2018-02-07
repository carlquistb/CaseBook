use master
go
drop database CASEBOOK_V2
go
create database CASEBOOK_V2
go
use CASEBOOK_V2
go
create table [tblFACILITY_TYPE]
	(
		FacilityTypeID int identity(1,1),
		FacilityTypeName nvarchar(100) not null,
		FacilityTypeDescr nvarchar(500)

		constraint pk_tblFACILITY_TYPE primary key (FacilityTypeID)
	)
create table [tblFACILITY]
	(
		FacilityID int identity(1,1),
		FacilityName nvarchar(100) not null,
		FacilityDescr nvarchar(500),
		FacilityTypeID int not null

		constraint pk_tblFACILITY primary key (FacilityID),
		constraint fk_tblFACILITY_FacilityTypeID foreign key (FacilityTypeID) references [tblFACILITY_TYPE](FacilityTypeID)
	)
create table [tblEQUIPMENT_TYPE]
	(
		EquipmentTypeID int identity(1,1),
		EquipmentTypeName nvarchar(100) not null,
		EquipmentTypeDescr nvarchar(500)

		constraint pk_tblEQUIPMENT_TYPE primary key (EquipmentTypeID)
	)
create table [tblEQUIPMENT_SUBTYPE]
	(
		EquipmentSubtypeID int identity(1,1),
		EquipmentSubtypeName nvarchar(100) not null,
		EquipmentSubtypeDescr nvarchar(500),
		EquipmentTypeID int not null foreign key references [tblEQUIPMENT_TYPE](EquipmentTypeID)

		constraint pk_tblEQUIPMENT_SUBTYPE primary key (EquipmentSubtypeID),
		constraint fk_tblEQUIPMENT_SUBTYPE_EquipmentTypeID foreign key (EquipmentTypeID) references [tblEQUIPMENT_TYPE](EquipmentTypeID)
	)
create table [tblEQUIPMENT]
	(
		EquipmentID int identity(1,1),
		EquipmentName nvarchar(100) not null,
		EquipmentDescr nvarchar(500),
		ReplacementCost money,
		EquipmentTypeID int not null foreign key references [tblEQUIPMENT_SUBTYPE](EquipmentSubtypeID)

		constraint pk_tblEQUIPMENT primary key (EquipmentID)
	)
create table [tblEQUIPMENT_FACILITY]
	(
		EqFacID int identity(1,1) primary key,
		EqID int not null foreign key references [tblEQUIPMENT](EquipmentID),
		FacID int not null foreign key references [tblFACILITY](FacilityID)
	)
create table [tblFEE_TYPE]
	(
		FeeTypeID int identity(1,1) primary key,
		FeeTypeName nvarchar(100) not null,
		FeeTypeDescr nvarchar(500)
	)
create table [tblFEE]
	(
		FeeID int identity(1,1) primary key,
		FeeName nvarchar(100) not null,
		FeeDescr nvarchar(500),
		FeeAmount money,
		FeeTypeID int not null foreign key references [tblFEE_TYPE](FeeTypeID)
	)
create table [tblFEE_HISTORY]
	(
		FeeHistoryID int identity primary key,
		FeeID int not null foreign key references [tblFEE](FeeID),
		FeeAmount money,
		FeeHistoryDate date
	)
create table [tblPERSON]
	(
		PersonID int identity(1,1) primary key,
		Fname nvarchar(100) not null,
		Lname nvarchar(100) not null,
		Mname nvarchar(100),
		BirthDate date not null,
		Email nvarchar(500)
	)
create table [tblROLE]
	(
		RoleID int identity(1,1) primary key,
		RoleName nvarchar(100) not null,
		RoleDescr nvarchar(500)
	)
create table [tblPERSON_ROLE]
	(
		P_R_ID int identity(1,1) primary key,
		PersonID int not null foreign key references [tblPERSON](PersonID),
		RoleID int not null foreign key references [tblROLE](RoleID),
		BeginDate date,
		EndDate date
	)
create table [tblEVENT_TYPE]
	(
		EventTypeID int identity(1,1) primary key,
		EventTypeName nvarchar(100) not null,
		EventTypeDescr nvarchar(500)
	)
create table [tblTRANSMITTAL]
	(
		TransmittalID int identity(1,1) primary key,
		TransmittalName nvarchar(100) not null,
		TransmittalAmount money,
		TransmittalDate date
	)
create table [tblEVENT]
	(
		EventID int identity(1,1) primary key,
		EventName nvarchar(100) not null,
		EventDate date not null,
		EventTypeID int not null foreign key references [tblEVENT_TYPE](EventTypeID),
		EquipmentID int not null foreign key references [tblEQUIPMENT](EquipmentID),
		FeeID int not null foreign key references [tblFEE](FeeID),
		P_R_ID int not null foreign key references [tblPERSON_ROLE](P_R_ID),
	)
create table [tblEVENT_TRANSMITTAL]
	(
		EventTransmittalID int identity(1,1) primary key,
		EventID int not null foreign key references [tblEVENT](EventID),
		TRANSMITTALID int not null foreign key references [tblTRANSMITTAL](TransmittalID),
		amount money
	)
create table [tblCOMMENT]
	(
		CommentID int identity(1,1) primary key,
		CommentDate date not null,
		EventID int not null foreign key references [tblEVENT](EventID),
		CommentBody nvarchar(1000)
	)
