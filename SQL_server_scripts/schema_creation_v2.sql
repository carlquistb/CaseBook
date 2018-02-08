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
		EquipmentTypeID int not null

		constraint pk_tblEQUIPMENT_SUBTYPE primary key (EquipmentSubtypeID),
		constraint fk_tblEQUIPMENT_SUBTYPE_EquipmentTypeID foreign key (EquipmentTypeID) references [tblEQUIPMENT_TYPE](EquipmentTypeID)
	)
create table [tblEQUIPMENT]
	(
		EquipmentID int identity(1,1),
		EquipmentName nvarchar(100) not null,
		EquipmentDescr nvarchar(500),
		ReplacementCost money,
		EquipmentSubtypeID int not null

		constraint pk_tblEQUIPMENT primary key (EquipmentID)
		constraint fk_tblEQUIPMENT_EquipmentSubtypeID foreign key (EquipmentSubtypeID) references [tblEQUIPMENT_SUBTYPE](EquipmentSubtypeID)
	)
create table [tblEQUIPMENT_FACILITY]
	(
		EqFacID int identity(1,1),
		EqID int not null foreign key references [tblEQUIPMENT](EquipmentID),
		FacID int not null foreign key references [tblFACILITY](FacilityID)

		constraint pk_tblEQUIPMENT_FACILITY primary key (EqFacID)
	)
create table [tblFEE_TYPE]
	(
		FeeTypeID int identity(1,1),
		FeeTypeName nvarchar(100) not null,
		FeeTypeDescr nvarchar(500)

		constraint pk_tblFEE_TYPE primary key (FeeTypeID)
	)
create table [tblFEE]
	(
		FeeID int identity(1,1),
		FeeName nvarchar(100) not null,
		FeeDescr nvarchar(500),
		FeeAmount money,
		FeeTypeID int not null

		constraint pk_tblFEE primary key (FeeID),
		constraint fk_tblFEE_FeeTypeID foreign key (FeeTypeID) references [tblFEE_TYPE](FeeTypeID)
	)
create table [tblFEE_HISTORY]
	(
		FeeHistoryID int identity,
		FeeID int not null,
		FeeAmount money,
		FeeHistoryDate date

		constraint pk_tblFEE_HISTORY primary key (FeeHistoryID),
		constraint fk_tblFEE_HISTORY_FeeID foreign key (FeeID) references [tblFEE](FeeID)
	)
create table [tblPERSON]
	(
		PersonID int identity(1,1),
		Fname nvarchar(100) not null,
		Lname nvarchar(100) not null,
		Mname nvarchar(100),
		BirthDate date not null,
		Email nvarchar(500)

		constraint pk_tblPERSON primary key (PersonID)
	)
create table [tblROLE]
	(
		RoleID int identity(1,1),
		RoleName nvarchar(100) not null,
		RoleDescr nvarchar(500)

		constraint pk_tblROLE primary key (RoleID)
	)
create table [tblPERSON_ROLE]
	(
		P_R_ID int identity(1,1),
		PersonID int not null,
		RoleID int not null),
		BeginDate date,
		EndDate date

		constraint pk_tblPERSON_ROLE primary key (P_R_ID),
		constraint fk_tblPERSON_ROLE_PersonID foreign key (PersonID) references [tblPERSON](PersonID),
		constraint fk_tblPERSON_ROLE_RoleID foreign key (RoleID) references [tblROLE](RoleID)
	)
create table [tblEVENT_TYPE]
	(
		EventTypeID int identity(1,1),
		EventTypeName nvarchar(100) not null,
		EventTypeDescr nvarchar(500)

		constraint pk_tblEVENT_TYPE primary key (EventTypeID)
	)
create table [tblTRANSMITTAL]
	(
		TransmittalID int identity(1,1),
		TransmittalName nvarchar(100) not null,
		TransmittalAmount money,
		TransmittalDate date

		constraint pk_tblTRANSMITTAL primary key (TransmittalID)
	)
create table [tblEVENT]
	(
		EventID int identity(1,1),
		EventName nvarchar(100) not null,
		EventDate date not null,
		EventTypeID int not null,
		EquipmentID int not null,
		FeeID int not null,
		P_R_ID int not null

		constraint pk_tblEVENT primary key (EventID),
		constraint fk_tblEVENT_EventTypeID foreign key (EventTypeID) references [tblEVENT_TYPE](EventTypeID),
		constraint fk_tblEVENT_EquipmentID foreign key (EquipmentID) references [tblEQUIPMENT](EquipmentID),
		constraint fk_tblEVENT_FeeID foreign key (FeeID) references [tblFEE](FeeID),
		constraint fk_tblEVENT_P_R_ID foreign key (P_R_ID) references [tblPERSON_ROLE](P_R_ID)
	)
create table [tblEVENT_TRANSMITTAL]
	(
		EventTransmittalID int identity(1,1),
		EventID int not null,
		TransmittalID int not null,
		amount money

		constraint pk_tblEVENT_TRANSMITTAL primary key (EventTransmittalID),
		constraint fk_tblEVENT_TRANSMITTAL_EventID foreign key (EventID) references [tblEVENT](EventID),
		constraint fk_tblEVENT_TRANSMITTAL_TransmittalID foreign key (TransmittalID) references [tblTRANSMITTAL](TransmittalID)
	)
create table [tblCOMMENT]
	(
		CommentID int identity(1,1),
		CommentDate date not null,
		EventID int not null,
		CommentBody nvarchar(1000)

		constraint pk_tblCOMMENT primary key (CommentID),
		constraint fk_tblCOMMENT_EventID foreign key (EventID) references [tblEVENT](EventID),
	)
