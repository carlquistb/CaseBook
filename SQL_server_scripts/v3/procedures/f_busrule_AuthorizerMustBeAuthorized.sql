alter function f_busrule_AuthorizerMustBeAuthorized()
returns int
as
begin
	declare @ret int
	if exists (
			select * from tblRENTAL R 
				join tblAUTHORIZER A on R.AuthorizerID = A.AuthorizerID
				join tblEQ EQ on EQ.EqID = R.EqID
				where A.EqSubtypeID != EQ.EqSubtypeID
			)
		set @ret = 1
	else
		set @ret = 0
	return @ret
end
go

alter table tblRENTAL add constraint ck_busrule_AuthorizerMustBeAuthorized check (dbo.f_busrule_AuthorizerMustBeAuthorized() = 0)
