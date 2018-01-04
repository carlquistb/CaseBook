/*
Brendan Carlquist
*/
use CASEBOOK_DB_d2;

delimiter $$

create procedure usp_insert_EQ_TYPE 
	(
		p_name varchar(100),
		p_descr varchar(500),
		p_term_length int
    )
begin
	insert into tblEQ_TYPE (object_name,descr,term_length) values (p_name,p_descr,p_term_length);
end$$

create procedure usp_insert_EQ_SUBTYPE
	(
		p_eq_type_id int,
		p_name varchar(100),
		p_model varchar(100),
		p_descr varchar(500),
		p_replace_cost decimal(13,2)
    )
begin
	insert into tblEQ_SUBTYPE (eq_type_id, object_name, model, descr, replace_cost)
    values (p_eq_type_id, p_object_name, p_model, p_descr, p_replace_cost);
end$$

create procedure usp_insert_EQ
	(
		p_eq_subtype_id varchar(100),
		p_eq_serial int
    )
begin
	insert into tblEQ (eq_subtype_id, eq_serial)
    values (p_eq_subtype_id, p_eq_serial);
end$$

create procedure usp_insert_person
	(
        p_f_name varchar(100),
        p_m_name varchar(100),
        p_l_name varchar(100),
        p_dob date,
        p_email varchar(100),
        p_phone varchar(100),
        p_city varchar(100),
        p_state varchar(100),
        p_zip_code varchar(100)
    )
begin
	insert into tblPERSON (f_name, m_name, l_name, dob, email, phone, city, state, zip_code)
    values (p_f_name, p_m_name, p_l_name, p_dob, p_email, p_phone, p_city, p_state, p_zip_code);
end$$

create procedure usp_insert_address
	(
		p_line_1 varchar(100),
		p_line_2 varchar(100),
		p_line_3 varchar(100),
		p_city varchar(100),
		p_state varchar(2),
		p_zipcode varchar(10),
		p_init_date date,
		p_person_id int
	)
begin
	insert into tblADDRESS (line_1, line_2, line_3, city, state, zipcode, init_date, person_id)
    values (p_line_1, p_line_2, p_line_3, p_city, p_state, p_zipcode, p_init_date, p_person_id);
end$$

create procedure usp_insert_role
	(
		p_name varchar(100),
        p_descr varchar(500),
        p_term_length int,
        p_key_1_cost decimal(13,2),
        p_key_2_cost decimal(13,2),
        p_key_3_cost decimal(13,2),
        p_key_4_cost decimal(13,2),
        p_key_n_cost decimal(13,2)
	)
begin
	insert into tblROLE (object_name, descr, term_length, key_1_cost, key_2_cost, key_3_cost, key_4_cost, key_n_cost)
    values (p_name, p_descr, p_term_length, p_key_1_cost, p_key_2_cost, p_key_3_cost, p_key_4_cost, p_key_n_cost);
end$$