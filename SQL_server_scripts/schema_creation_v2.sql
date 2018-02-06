use master
go
drop database CASEBOOK_V2
go
create database CASEBOOK_V2
go
use CASEBOOK_V2
go
create table [FACILITY_TYPE]
	(
		FacilityTypeID int identity(1,1) primary key,
		FacilityTypeName nvarchar(100) not null,
		FacilityTypeDescr nvarchar(500)
	)
create table [FACILITY]
	(
		FacilityID int identity(1,1) primary key,
		FacilityName nvarchar(100) not null,
		FacilityDescr nvarchar(500),
		FacilityTypeID int not null foreign key references [FACILITY_TYPE](FacilityTypeID)
	)
create table [EQUIPMENT_TYPE]
	(
		EquipmentTypeID int identity(1,1) primary key,
		EquipmentTypeName nvarchar(100) not null,
		EquipmentTypeDescr nvarchar(500)
	)
create table [EQUIPMENT_SUBTYPE]
	(
		EquipmentSubtypeID int identity(1,1) primary key,
		EquipmentSubtypeName nvarchar(100) not null,
		EquipmentSubtypeDescr nvarchar(500),
		EquipmentTypeID int not null foreign key references [EQUIPMENT_TYPE](EquipmentTypeID)
	)
create table [EQUIPMENT]
	(
		EquipmentID int identity(1,1) primary key,
		EquipmentName nvarchar(100) not null,
		EquipmentDescr nvarchar(500),
		ReplacementCost money,
		EquipmentTypeID int not null foreign key references [EQUIPMENT_SUBTYPE](EquipmentSubtypeID)
	)
create table [EQUIPMENT_FACILITY]
	(
		EqFacID int identity(1,1) primary key,
		EqID int not null foreign key references [EQUIPMENT](EquipmentID),
		FacID int not null foreign key references [FACILITY](FacilityID)
	)
create table [FEE_TYPE]
	(
		FeeTypeID int identity(1,1) primary key,
		FeeTypeName nvarchar(100) not null,
		FeeTypeDescr nvarchar(500)
	)
create table [FEE]
	(
		FeeID int identity(1,1) primary key,
		FeeName nvarchar(100) not null,
		FeeDescr nvarchar(500),
		FeeAmount money,
		FeeTypeID int not null foreign key references [FEE_TYPE](FeeTypeID)
	)
create table [FEE_HISTORY]
	(
		FeeHistoryID int identity primary key,
		FeeID int not null foreign key references [FEE](FeeID),
		FeeAmount money,
		FeeHistoryDate date
	)
create table [PERSON]
	(
		PersonID int identity(1,1) primary key,
		Fname nvarchar(100) not null,
		Lname nvarchar(100) not null,
		Mname nvarchar(100),
		BirthDate date not null,
		Email nvarchar(500)
	)
create table [ROLE]
	(
		RoleID int identity(1,1) primary key,
		RoleName nvarchar(100) not null,
		RoleDescr nvarchar(500)
	)
create table [PERSON_ROLE]
	(
		P_R_ID int identity(1,1) primary key,
		PersonID int not null foreign key references [PERSON](PersonID),
		RoleID int not null foreign key references [ROLE](RoleID),
		BeginDate date,
		EndDate date
	)
create table [EVENT_TYPE]
	(
		EventTypeID int identity(1,1) primary key,
		EventTypeName nvarchar(100) not null,
		EventTypeDescr nvarchar(500)
	)
create table [TRANSMITTAL]
	(
		TransmittalID int identity(1,1) primary key,
		TransmittalName nvarchar(100) not null,
		TransmittalAmount money,
		TransmittalDate date
	)
create table [EVENT]
	(
		EventID int identity(1,1) primary key,
		EventName nvarchar(100) not null,
		EventDate date not null,
		EventTypeID int not null foreign key references [EVENT_TYPE](EventTypeID),
		EquipmentID int not null foreign key references [EQUIPMENT](EquipmentID),
		FeeID int not null foreign key references [FEE](FeeID),
		P_R_ID int not null foreign key references [PERSON_ROLE](P_R_ID),
	)
create table [EVENT_TRANSMITTAL]
	(
		EventTransmittalID int identity(1,1) primary key,
		EventID int not null foreign key references [EVENT](EventID),
		TRANSMITTALID int not null foreign key references [TRANSMITTAL](TransmittalID),
		amount money
	)
create table [COMMENT]
	(
		CommentID int identity(1,1) primary key,
		CommentDate date not null,
		EventID int not null foreign key references [EVENT](EventID),
		CommentBody nvarchar(1000)
	)
