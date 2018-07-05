--business rule
-- a person can't have the same key checked out to multiple person_roles.

create function f_busrule_PeopleGetOneOfEachSubtypeAtATime()
returns int
as
begin
	declare @ret int = 0
	if exists (
		select count(*) as [count], p.PersonID, eq.EqSubtypeID 
		from tblRENTAL r
			join tblEQ eq on eq.EqID = r.EqID
			join tblEQ_SUBTYPE st on st.EqSubtypeID = eq.EqSubtypeID
			join tblPERSON_ROLE pr on r.RenterID = pr.PersonRoleID
			join tblPERSON p on p.PersonID = pr.PersonID
		group by p.PersonID, eq.EqSubtypeID
		having count(*) > 1
	)
	begin
		set @ret = 1
	end
	return @ret
end
go

alter table tblRENTAL add constraint ch_busrule_PeopleGetOneOfEachSubtypeAtATime check (dbo.f_busrule_PeopleGetOneOfEachSubtypeAtATime() = 0)
