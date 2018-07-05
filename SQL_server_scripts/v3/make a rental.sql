--make a new rental. Lets say, rent a master key to myself.
select * from v_PRDetails prd where prd.FName = 'Brendan' or prd.FName = 'Colin'

select eq.EqID, EqSubtypeID, eq.EQsubtype from v_EQ eq where eq.EQsubtype = 'J25A'

select * from tblAUTHORIZER a join v_PRDetails d on d.PersonRoleID = a.PersonRoleID where a.EqSubtypeID = 1 and FName = 'Doug'

insert into tblRENTAL (EqID, RenterID, EmployeeID, AuthorizerID, expReturnDate)
	values (187, 1239, 1238, 6, '2018-07-02')