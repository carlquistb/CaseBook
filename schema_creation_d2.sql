/*
Brendan Carlquist
*/

create database CASEBOOK_DB_d2;

use CASEBOOK_DB_d2;

show databases;

create table tblROLE
	(
		role_id int primary key auto_increment,
		object_name varchar(100) not null unique,
		descr varchar(500) not null,
		term_length int not null,
		key_1_cost decimal(13,2) not null,
		key_2_cost decimal(13,2) not null,
		key_3_cost decimal(13,2) not null,
		key_4_cost decimal(13,2) not null,
		key_n_cost decimal(13,2) not null
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
        replace_cost decimal(13,2)
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
		transmittal_id int primary key auto_increment,
        total_amount decimal(13,2) not null,
        transmit_date date not null,
        transmit_number varchar(100) not null,
        note varchar(500)
	);

create table tblPERSON
	(
		person_id int primary key auto_increment,
        f_name varchar(100) not null,
        m_name varchar(100),
        l_name varchar(100) not null,
        dob date not null,
        email varchar(100),
        phone varchar(100),
        city varchar(100),
        state varchar(100),
        zip_code varchar(100)
    );
alter table tblPERSON add index (f_name);
alter table tblPERSON add index (l_name);

create table tblADDRESS
	(
		address_id int primary key auto_increment,
		line_1 varchar(100) not null,
		line_2 varchar(100),
		line_3 varchar(100),
		city varchar(100) not null,
		state varchar(2) not null,
		zipcode varchar(10) not null,
		init_date date not null,
		person_id int not null
    );
alter table tblADDRESS add foreign key (person_id) references tblPERSON(person_id);

create table tblPERSON_ROLE
	(
		person_role_id int primary key auto_increment,
        person_id int not null,
        role_id int not null,
        start_date date not null,
        end_date date not null,
        role_id_number varchar(100)
    );
alter table tblPERSON_ROLE add foreign key (person_id) references tblPERSON(person_id);
alter table tblPERSON_ROLE add foreign key (role_id) references tblROLE(role_id);
alter table tblPERSON_ROLE add index (role_id_number);

create table tblRENTAL
	(
		rental_id int primary key auto_increment,
        renter_id int not null,
        emp_id int not null,
        approver_id int not null,
        eq_id int not null,
        exp_ret_date date not null,
        end_date date,
        begin_date date,
        deposit_amount decimal(13,2),
        refund_amount decimal(13,2)
    );
alter table tblRENTAL add foreign key (renter_id) references tblPERSON_ROLE(person_role_id);
alter table tblRENTAL add foreign key (emp_id) references tblPERSON_ROLE(person_role_id);
alter table tblRENTAL add foreign key (approver_id) references tblPERSON_ROLE(person_role_id);
alter table tblRENTAL add foreign key (eq_id) references tblEQ(eq_id);
alter table tblRENTAL add index (exp_ret_date);

create table tblRENTAL_NOTE
	(
		rental_note_id int primary key auto_increment,
        rental_id int not null,
        writer_id int not null,
        note varchar(500),
        init_date date
    );
alter table tblRENTAL_NOTE add foreign key (rental_id) references tblRENTAL(rental_id);
alter table tblRENTAL_NOTE add foreign key (writer_id) references tblPERSON_ROLE(person_role_id);
alter table tblRENTAL_NOTE add index (rental_id);
alter table tblRENTAL_NOTE add index (writer_id);

create table tblSIG
	(
		sig_id int primary key auto_increment,
		file_path varchar(100),
        rental_id int not null
    );
alter table tblSIG add foreign key (rental_id) references tblRENTAL(rental_id);

create table tblRENTAL_TRANSMITTAL
	(
		rental_transmittal_id int primary key auto_increment,
        rental_id int not null,
        transmittal_id int not null
    );
alter table tblRENTAL_TRANSMITTAL add foreign key (rental_id) references tblRENTAL(rental_id);
alter table tblRENTAL_TRANSMITTAL add foreign key (transmittal_id) references tblTRANSMITTAL(transmittal_id);