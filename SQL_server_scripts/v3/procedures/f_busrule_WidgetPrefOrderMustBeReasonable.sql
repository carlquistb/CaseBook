--business rule
-- no preferece can be set where the order number is more than the total number of widgets. 
-- This would mean that there is a problem in the web code that allows users to reorder widgets.

create function f_busrule_WidgetPrefOrderMustBeReasonable()
	returns int
as
begin
	declare @ret int = 0
	if exists (select * from tblWIDGET_PREFERENCE_PERSON wpp join tblWIDGET_PREFERENCE wp on wp.PreferenceID = wpp.PreferenceID where wp.PrefOrder > (select count(*) from tblWIDGET))
		begin
		set @ret = 1
		end
	return @ret
end
go

alter table tblWIDGET_PREFERENCE_PERSON add constraint ch_busrule_WidgetPrefOrderMustBeReasonable check (dbo.f_busrule_WidgetPrefOrderMustBeReasonable() = 0)
