create database CaseBook_v1

use CaseBook_v1

CREATE TABLE tblEQ_TYPE 
	(
		[EQ_TYPE_ID] INT IDENTITY(1,1) PRIMARY KEY,
		[NAME] NVARCHAR(100) NOT NULL,
		[DEFAULT_TERM_LENGTH] INT NOT NULL,
		descr NVARCHAR(500)
	)
GO

CREATE TABLE tblEQ_SUBTYPE
	(
		[EQ_SUBTYPE_id] INT IDENTITY(1,1) PRIMARY KEY,
		[EQ_TYPE_ID] INT NOT NULL FOREIGN KEY REFERENCES tblEQ_TYPE([EQ_TYPE_ID]),
		[NAME] NVARCHAR(100) NOT NULL,
		[MODEL] NVARCHAR(100),
		[DESCR] NVARCHAR(500),
		[COST] MONEY,
		[REPLACE_COST] MONEY
	)
GO

CREATE TABLE tblEQ
	(
		[EQ_ID] INT IDENTITY(1,1) PRIMARY KEY,
		[EQ_SUBTYPE_ID] INT NOT NULL FOREIGN KEY REFERENCES tblEQ_SUBTYPE([EQ_SUBTYPE_ID]),
		[EQ_SERIAL] INT NOT NULL
	)
go

CREATE TABLE tblADDRESS
	(
		[ADDRESS_ID] int identity(1,1) primary key,
		[LINE_1] nvarchar(100),
		[LINE_2] nvarchar(100),
		[LINE_3] nvarchar(100),
		[CITY] nvarchar(100),
		[STATE] nvarchar(100),
		[ZIPCODE] nvarchar(100),
		[DATE] nvarchar(100)
	)
go

CREATE TABLE tblEMAIL
	(
		[EMAIL_ID] int identity(1,1) primary key,
		[EMAIL_NAME] nvarchar(100),
		[EMAIL_ADDRESS] nvarchar(500) not null
	)
go

create table tblPHONE
	(
		[PHONE_ID] int identity(1,1) primary key,
		[PHONE_NAME] nvarchar(100),
		[PHONE_NUMBER] nvarchar(100) not null
	)
go

create table tblTRANSMITTAL
	(
		[TRANSMITTAL_ID] int identity(1,1) primary key,
		[TOTAL_AMOUNT] money not null,
		[DATE] date not null,
		[NOTE] nvarchar(500)
	)
go

create table tblPERSON
	(
		[PERSON_ID] int identity(1,1) primary key,
		[F_NAME] nvarchar(100) not null,
		[M_NAME] nvarchar(100),
		[L_NAME] nvarchar(100) not null,
		[DOB] date
	)
go

create table tblROLE
	(
		[ROLE_ID] int identity(1,1) primary key,
		[NAME] nvarchar(100) not null,
		[DESC] nvarchar(500),
		[TERM_LENGTH] int,
		[KEY_1_COST] money not null,
		[KEY_2_COST] money not null,
		[KEY_3_COST] money not null,
		[KEY_N_COST] money not null
	)
go

create table tblPERSON_ROLE
	(
		[PERSON_ROLE_ID] int identity(1,1) primary key,
		[PERSON_ID] int not null foreign key references [tblPERSON]([PERSON_ID]),
		[ROLE_ID] int not null foreign key references [tblROLE]([ROLE_ID]),
		[START_DATE] date not null,
		[END_DATE] date,
		[ROLE_ID_NUMBER] nvarchar(100)
	)
go

create table tblADDRESS_PERSON_ROLE
	(
		[ADDRESS_PERSON_ROLE_ID] int identity(1,1) primary key,
		[PERSON_ROLE_ID] int not null foreign key references [tblPERSON_ROLE]([PERson_ROLE_ID]),
		[ADDRESS_ID] int not null foreign key references [tblADDRESS]([ADDRESS_ID])
	)
go

create table tblEMAIL_PERSON_ROLE
	(
		[EMAIL_PERSON_ROLE_ID] int identity(1,1) primary key,
		[PERSON_ROLE_ID] int not null foreign key references [tblPERSON_ROLE]([PERson_ROLE_ID]),
		[EMAIL_ID] int not null foreign key references [tblEMAIL]([EMAIL_ID])
	)
go

create table tblPHONE_PERSON_ROLE
	(
		[PHONEL_PERSON_ROLE_ID] int identity(1,1) primary key,
		[PERSON_ROLE_ID] int not null foreign key references [tblPERSON_ROLE]([PERson_ROLE_ID]),
		[PHONE_ID] int not null foreign key references [tblPHONE]([PHONE_ID])
	)
go

create table tblUSE
	(
		[USE_ID] int identity(1,1) primary key,
		[USER_ID] int not null foreign key references [tblPERSON_ROLE]([PERSON_ROLE_ID]),
		[EMP_ID] int not null foreign key references [tblPERSON_ROLE]([PERSON_ROLE_ID]),
		[EQ_ID] int not null foreign key references [tblEQ]([EQ_ID]),
		[BEGIN_DATE] date not null,
		[SIG_FILE_PATH] nvarchar(500)
	)
go

create table tblPURCHASE
	(
		[PURCHASE_ID] int identity(1,1) primary key,
		[USE_ID] int not null foreign key references [tblUSE]([USE_ID]),
	)
go

create table tblRENTAL
	(
		[RENTAL_ID] int identity(1,1) primary key,
		[USE_ID] int not null foreign key references [tblUSE]([USE_ID]),
		[APPROVER_ID] int not null foreign key references [tblPERSON_ROLE]([PERSON_ROLE_ID]),
		[EXP_RETURN_DATE] date not null,
		[END_DATE] date not null
	)
go

create table tblUSE_NOTE
	(
		[USE_NOTE_ID] int identity(1,1) primary key,
		[USE_ID] int not null foreign key references [tblUSE]([USE_ID]),
		[WRITER_ID] int not null foreign key references [tblPERSON_ROLE]([PERSON_ROLE_ID]),
		[NOTE] nvarchar(500),
		[REF_USE_NOTE_ID] int, --foreign key references its own table? Fun!! Can we do it?
		[DATE] date not null
	)
go

create table tblCASH_MVNT
	(
		[MVNT_ID] int identity(1,1) primary key,
		[USE_ID] int not null foreign key references [tblUSE]([USE_ID]),
		[TRANSMITTAL_ID] int not null foreign key references [tblTRANSMITTAL]([TRANSMITTAL_ID]),
		[AMOUNT] money not null
	)