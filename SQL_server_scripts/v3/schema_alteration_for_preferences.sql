create table tblWIDGET
	(
		WidgetID int identity(1,1) not null,
		WidgetName nvarchar(50) not null,
		WidgetDescr	nvarchar(50)

		constraint pk_tblWIDGET primary key (WidgetID)
	)


create table tblWIDGET_PREFERENCE
	(
		PreferenceID int identity(1,1) not null,
		PrefOrder int not null,
		PrefSize int not null

		constraint pk_tblWIDGETPREFERENCE primary key (PreferenceID)
	)

create table tblWIDGET_PREFERENCE_PERSON
	(
		WidgetPreferencePersonID int identity(1,1) not null,
		PreferenceID int not null,
		WidgetID int not null,
		PersonID int not null,
		SetDate datetime not null default(getdate())

		constraint pk_tblWIDGETPREFERENCEPERSON primary key (WidgetPreferencePersonID),
		constraint fk_tblWIDGETPREFERENCEPERSON_PreferenceID foreign key (PreferenceID) references tblWIDGET_PREFERENCE(PreferenceID),
		constraint fk_tblWIDGETPREFERENCEPERSON_WidgetID foreign key (WidgetID) references tblWIDGET(WidgetID),
		constraint fk_tblWIDGETPREFERENCEPERSON_PersonID foreign key (PersonID) references tblPERSON(PersonID)
	)

select * from sysobjects