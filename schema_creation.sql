create database CASEBOOK_DB;

use CASEBOOK_DB;

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

create table tblEQ_TYPE
	(
		eq_type_id int primary key auto_increment,
        name varchar(100) not null unique,
        descr varchar(500) not null,
        term_length int not null
	);
    
create table tblEQ_SUBTYPE
	(
		eq_subtype_id int primary key auto_increment,
        name varchar(100) not null unique,
        model varchar(100),
        descr varchar(500),
        replace_cost float
	);

alter table tblEQ_SUBTYPE add (eq_type_id int not null);
alter table tblEQ_SUBTYPE add foreign key (eq_type_id) references tblEQ_TYPE(eq_type_id);