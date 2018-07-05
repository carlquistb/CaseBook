create table tblPOOL
	(
		PoolID int identity(1,1) not null,
		PoolPriority int not null default 1,
		PoolFrequency int not null

		constraint pk_tblPOOL primary key (PoolID)
	)
go
create table tblAUDIT
	(
		AuditID int identity(1,1) not null,
		PoolID int not null,
		InitDate datetime not null default getdate()

		constraint pk_tblAUDIT primary key (AuditID),
		constraint fk_tblAUDIT_PoolID foreign key (PoolID) references tblPOOL(PoolID)
	)
go
create table tblPOOL_PERSONROLE
	(
		PoolPersonRoleID int identity(1,1) not null,
		PoolID int not null,
		PersonRoleID int not null

		constraint pk_tblPOOLPERSONROLE primary key (PoolPersonRoleID),
		constraint fk_tblPOOLPERSONROLE_PoolID foreign key (PoolID) references tblPOOL(PoolID),
		constraint fk_tblPOOLPERSONROLE_PersonRoleID foreign key (PersonRoleID) references tblPERSON_ROLE(PersonRoleID)
	)
go
create table tblPOOL_EQSUBTYPE
	(
		PoolEqSubtypeID int identity(1,1) not null,
		PoolID int not null,
		EqSubtypeID int not null

		constraint pk_tblPOOLEQSUBTYPE primary key (PoolEqSubtypeID),
		constraint fk_tblPOOLEQSUBTYPE_PoolID foreign key (PoolID) references tblPOOL(PoolID),
		constraint fk_tblPOOLEQSUBTYPE_EqSubtypeID foreign key (EqSubtypeID) references tblEQ_SUBTYPE(EqSubtypeID)
	)
go
create table tblAUDIT_PERSONROLE
	(
		AuditPersonRoleID int identity(1,1) not null,
		AuditID int not null,
		PersonRoleID int not null

		constraint pk_tblAUDITPERSONROLE primary key (AuditPersonRoleID),
		constraint fk_tblAUDITPERSONROLE_PoolID foreign key (AuditID) references tblAudit(AuditID),
		constraint fk_tblAUDITPERSONROLE_PersonRoleID foreign key (PersonRoleID) references tblPERSON_ROLE(PersonRoleID)
	)
go
create table tblAUDIT_EQSUBTYPE
	(
		AuditEqSubtypeID int identity(1,1) not null,
		AuditID int not null,
		EqSubtypeID int not null

		constraint pk_tblAUDITEQSUBTYPE primary key (AuditEqSubtypeID),
		constraint fk_tblAUDITEQSUBTYPE_PoolID foreign key (AuditID) references tblAUDIT(AuditID),
		constraint fk_tblAUDITEQSUBTYPE_EqSubtypeID foreign key (EqSubtypeID) references tblEQ_SUBTYPE(EqSubtypeID)
	)

alter table tblPOOL add PoolName nvarchar(50) not null
go
alter table tblPOOL add PoolDescr nvarchar(500)
go
alter table tblAUDIT_PERSONROLE add AuditingNote nvarchar(500)
go
alter table tblAUDIT_PERSONROLE add AuditingSuccess int
go
alter table tblAUDIT_EQSUBTYPE add AuditingNote nvarchar(500)
go
alter table tblAUDIT_EQSUBTYPE add AuditingSuccess int