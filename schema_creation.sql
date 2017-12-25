create database CASEBOOK_DB_d1;

use CASEBOOK_DB_d1;

show databases;

create table tblROLE
	(
		role_id int primary key auto_increment,
        name varchar(100) not null unique,
        descr varchar(500) not null,
        term_length int not null,
        key_1_cost float not null,
        key_2_cost float not null,
        key_3_cost float not null,
        key_n_cost float not null
	);
    
create table tblADDRESS
	(
		address_id int primary key auto_increment,
        sreet_number varchar(100) not null,
        street_name varchar(100) not null,
        city varchar(100) not null,
        state varchar(2) not null,
        zipcode varchar(10) not null,
        init_date date not null
    );

create table tblEQ_TYPE
	(
		eq_type_id int primary key auto_increment,
        object_name varchar(100) not null unique,
        descr varchar(500) not null,
        term_length int not null
	);
alter table tblEQ_TYPE add index (object_name);
    
create table tblEQ_SUBTYPE
	(
		eq_subtype_id int primary key auto_increment,
        eq_type_id int not null,
        object_name varchar(100) not null unique,
        model varchar(100),
        descr varchar(500),
        replace_cost float
	);
alter table tblEQ_SUBTYPE add foreign key (eq_type_id) references tblEQ_TYPE(eq_type_id);

create table tblEQ
	(
		eq_id int primary key auto_increment,
        eq_subtype_id int not null,
        eq_serial int not null
	);
    
alter table tblEQ add foreign key (eq_subtype_id) references tblEQ_SUBTYPE(eq_subtype_id);
alter table tblEQ add index (eq_serial);

create table tblTRANSMITTAL
	(
		transmittal_id int primary key auto_increment
	);