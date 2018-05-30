use master

drop database casebook_v3

go

create database casebook_v3

go

use casebook_v3

go

create table tblPERSON (
	PersonID int identity(1,1) not null,
	FName nvarchar(50) not null,
	MName nvarchar(50),
	LName nvarchar(50) not null,
	Email nvarchar(100) not null,
	Phone nvarchar(50)

	constraint pk_tblPERSON primary key (PersonID)
)

go

create table tblROLE (
	RoleID int identity(1,1) not null,
	RoleName nvarchar(50) not null,
	default_term int

	constraint pk_tblROLE primary key (RoleID)
)

go

create table tblPERSON_ROLE (
	PersonRoleID int identity(1,1) not null,
	PersonID int not null,
	RoleID int not null,
	BeginDate date not null,
	ExpEndDate date not null,
	EndDate date,
	RoleRef nvarchar(50)

	constraint pk_tblPERSONROLE primary key (PersonRoleID),
	constraint fk_tblPERSONROLE_PersonID foreign key (PersonID) references tblPERSON(PersonID),
	constraint fk_tblPERSONROLE_RoleID foreign key (RoleID) references tblROLE(RoleID)
)

go

create table tblTRANSMITAL (
	TransmitalID int identity(1,1) not null,
	TransmitalRef nvarchar(50) not null

	constraint pk_tblTRANSMITAL primary key (TransmitalID),
	constraint unique_TransmitalRef unique (TransmitalRef)
)

go

create table tblEQ_TYPE (
	EqTypeID int identity(1,1) not null,
	EqTypeName nvarchar(50) not null,
	DefaultRentalLength int

	constraint pk_tblEQTYPE primary key (EqTypeID)
)

go

create table tblEQ_SUBTYPE (
	EqSubtypeID int identity(1,1) not null,
	EqTypeID int not null,
	EqSubtypeName nvarchar(50) not null,
	DefaultRentalLength int,
	ReplaceCost money

	constraint pk_tblEQSUBTYPE primary key (EqSubtypeID),
	constraint fk_tblEQSUBTYPE_EqTypeID foreign key (EqTypeID) references tblEQ_TYPE(EqTypeID)
)

go

create table tblEQ (
	EqID int identity(1,1) not null,
	EqSubtypeID int not null,
	Serial int not null,
	EqInitDate date not null default(getdate())

	constraint pk_tblEQ primary key (EqID),
	constraint fk_tblEQ_EqSubtypeID foreign key (EqSubtypeID) references tblEQ_SUBTYPE(EqSubtypeID)
)

go

create table tblDISBURSE (
	DisburseID int identity(1,1) not null,
	PersonRoleID int not null,
	Amount money

	constraint pk_tblDISBURSE primary key (DisburseID),
	constraint fk_tblDISBURSE_PersonRoleID foreign key (PersonRoleID) references tblPERSON_ROLE(PersonRoleID)
)

go

create table tblRENTAL (
	RentalID int identity(1,1) not null,
	EqID int not null,
	fee money not null,
	RenterID int not null,
	EmployeeID int not null,
	AuthorizerID int not null,
	TransmitalID int not null

	constraint pk_tblRENTAL primary key (RentalID),
	constraint fk_tblRENTAL_EqID foreign key (EqID) references tblEQ(EqID),
	constraint fk_tblRENTAL_RenterID foreign key (RenterID) references tblPERSON_ROLE(PersonRoleID),
	constraint fk_tblRENTAL_EmployeeID foreign key (EmployeeID) references tblPERSON_ROLE(PersonRoleID),
	constraint fk_tblRENTAL_AuthorizerID foreign key (AuthorizerID) references tblPERSON_ROLE(PersonRoleID),
	constraint fk_tblRENTAL_TransmitalID foreign key (TransmitalID) references tblTRANSMITAL(TransmitalID)
)

go

create table tblEMAIL (
	EmailID int identity(1,1) not null,
	EmailName nvarchar(50) not null,
	EmailContents nvarchar(1000)

	constraint pk_tblEMAIL primary key (EmailID)
)

create table tblEMAIL_RENTAL (
	EmailRentalID int identity(1,1) not null,
	EmailID int not null,
	RentalID int not null,
	SentDate date not null,
	EmployeeID int not null

	constraint pk_tblEMAILRENTAL primary key (EmailRentalID),
	constraint fk_tblEMAILRENTAL_EmailID foreign key (EmailID) references tblEMAIL(EmailID),
	constraint fk_tblEMAILRENTAL_RentalID foreign key (RentalID) references tblRENTAL(RentalID),
	constraint fk_tblEMAILRENTAL_EmployeeID foreign key (EmployeeID) references tblPERSON_ROLE(PersonRoleID)
)

create table tblAUTHORIZER (
	AuthorizerID int identity(1,1) not null,
	PersonRoleID int not null,
	EqSubtypeID int not null

	constraint pk_tblAUTHORIZER primary key (AuthorizerID),
	constraint fk_tblAUTHORIZER_personRoleID foreign key (PersonRoleID) references tblPERSON_ROLE(PersonRoleID),
	constraint fk_tblAUTHORIZER_EqSubtypeID foreign key (EqSubtypeID) references tblEQ_SUBTYPE(EqSubtypeID)
)





