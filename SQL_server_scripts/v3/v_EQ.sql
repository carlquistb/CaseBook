--make a simple EQ view
--view IDs at the end.
--only show the actual default length and replace cost.

create view v_EQ
as
select 
	eq.serial as serial,
	st.EqSubtypeName as EQsubtype,
	t.EqTypeName as EQtype,
	st.ReplaceCost as replaceCost,
	st.DefaultRentalLength as rentalLength,
	t.DefaultRentalLength as defaultRentalLength,
	eq.EqID as EqID,
	st.EqSubtypeID as EqSubtypeID,
	t.EqTypeID as EqTypeID
from
	tblEQ eq
	join tblEQ_SUBTYPE st on st.EqSubtypeID = eq.EqSubtypeID
	join tblEQ_TYPE t on st.EqTypeID = t.EqTypeID