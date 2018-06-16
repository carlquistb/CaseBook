--assign random roles to each sample person
begin tran T1
declare @personID int = 1
declare @begin date
declare @roleID int
declare @enpEnd date
declare @end date
declare @roleRef nvarchar(50)
while (exists (select * from tblPERSON where PersonID = @personID))
begin
	declare @rand int = floor(rand()*100) --random number 0-99
	if (@rand < 65) begin --make them a norm undergrad
		set @begin = dateadd(day, -floor(rand()*365), cast(getdate() as date)) --random begin date from the last year
		set @roleID = (select RoleID from tblROLE where RoleName = 'UNDERGRADUATE')
		set @enpEnd = dateadd(day, (select default_term from tblROLE where RoleID = @roleID), @begin)
		insert into tblPERSON_ROLE (PersonID, RoleID, RoleRef, BeginDate, ExpEndDate)
			values (
				@personID, 
				@roleID,
				concat(cast(floor(rand()*10) as nvarchar(1)), cast(floor(rand()*10) as nvarchar(1)), cast(floor(rand()*10) as nvarchar(1)), cast(floor(rand()*10) as nvarchar(1)), cast(floor(rand()*10) as nvarchar(1)), cast(floor(rand()*10) as nvarchar(1)), cast(floor(rand()*10) as nvarchar(1))),
				@begin,
				@enpEnd
			)
	end
	else if (@rand < 80) begin -- make them a random grad student
		set @begin = dateadd(day, -(4*365)-floor(rand()*365*2), cast(getdate() as date)) --random begin date from the last year
		set @roleID = (select RoleID from tblROLE where RoleName = 'UNDERGRADUATE')
		set @enpEnd = dateadd(day, (select default_term from tblROLE where RoleID = @roleID), @begin)
		set @end = @enpEnd
		set @roleRef = 	concat(cast(floor(rand()*10) as nvarchar(1)), cast(floor(rand()*10) as nvarchar(1)), cast(floor(rand()*10) as nvarchar(1)), cast(floor(rand()*10) as nvarchar(1)), cast(floor(rand()*10) as nvarchar(1)), cast(floor(rand()*10) as nvarchar(1)), cast(floor(rand()*10) as nvarchar(1)))
		insert into tblPERSON_ROLE (PersonID, RoleID, RoleRef, BeginDate, ExpEndDate, EndDate)
			values (
				@personID, 
				@roleID,
				@roleRef,
				@begin,
				@enpEnd,
				@end
			)
		set @begin = dateadd(day, 45, @end)
		set @roleID = (select RoleID from tblROLE where RoleName = 'GRADUATE')
		set @enpEnd = dateadd(day, (select default_term from tblROLE where RoleID = @roleID), @begin)
		insert into tblPERSON_ROLE (PersonID, RoleID, RoleRef, BeginDate, ExpEndDate)
			values (
				@PersonID,
				@roleID,
				@roleRef,
				@begin,
				@enpEnd
			)				
	end
	else if (@rand < 85) begin -- make them a rand TA
		set @begin = dateadd(day, -(4*365)-floor(rand()*365*2), cast(getdate() as date)) --random begin date from the last year
		set @roleID = (select RoleID from tblROLE where RoleName = 'UNDERGRADUATE')
		set @enpEnd = dateadd(day, (select default_term from tblROLE where RoleID = @roleID), @begin)
		set @end = @enpEnd
		set @roleRef = 	concat(cast(floor(rand()*10) as nvarchar(1)), cast(floor(rand()*10) as nvarchar(1)), cast(floor(rand()*10) as nvarchar(1)), cast(floor(rand()*10) as nvarchar(1)), cast(floor(rand()*10) as nvarchar(1)), cast(floor(rand()*10) as nvarchar(1)), cast(floor(rand()*10) as nvarchar(1)))
		insert into tblPERSON_ROLE (PersonID, RoleID, RoleRef, BeginDate, ExpEndDate, EndDate)
			values (
				@personID, 
				@roleID,
				@roleRef,
				@begin,
				@enpEnd,
				@end
			)
		set @begin = dateadd(day, 45, @end)
		set @roleID = (select RoleID from tblROLE where RoleName = 'GRADUATE')
		set @enpEnd = dateadd(day, (select default_term from tblROLE where RoleID = @roleID), @begin)
		insert into tblPERSON_ROLE (PersonID, RoleID, RoleRef, BeginDate, ExpEndDate)
			values (
				@PersonID,
				@roleID,
				@roleRef,
				@begin,
				@enpEnd
			)
		set @begin = dateadd(day, floor(rand()*180), @begin)
		set @roleID = (select RoleID from tblROLE where RoleName = 'TA')
		set @enpEnd = dateadd(day, (select default_term from tblROLE where RoleID = @roleID), @begin)
		insert into tblPERSON_ROLE (PersonID, RoleID, RoleRef, BeginDate, ExpEndDate)
			values (
				@PersonID,
				@roleID,
				@roleRef,
				@begin,
				@enpEnd
			)
	end
	else if (@rand < 95) begin -- make them a random faculty
		set @begin = dateadd(day, -floor(rand()*365), cast(getdate() as date)) --random begin date from the last year
		set @roleID = (select RoleID from tblROLE where RoleName = 'FACULTY')
		set @enpEnd = dateadd(day, (select default_term from tblROLE where RoleID = @roleID), @begin)
		insert into tblPERSON_ROLE (PersonID, RoleID, RoleRef, BeginDate, ExpEndDate)
			values (
				@personID, 
				@roleID,
				concat(cast(floor(rand()*10) as nvarchar(1)), cast(floor(rand()*10) as nvarchar(1)), cast(floor(rand()*10) as nvarchar(1)), cast(floor(rand()*10) as nvarchar(1)), cast(floor(rand()*10) as nvarchar(1)), cast(floor(rand()*10) as nvarchar(1)), cast(floor(rand()*10) as nvarchar(1))),
				@begin,
				@enpEnd
			)
	end
	else if (@rand < 96) begin -- make them a random student staff
		set @begin = dateadd(day, -floor(rand()*180), cast(getdate() as date)) --random begin date from the last year
		set @roleID = (select RoleID from tblROLE where RoleName = 'STUDENT EMPLOYEE')
		set @enpEnd = dateadd(day, (select default_term from tblROLE where RoleID = @roleID), @begin)
		insert into tblPERSON_ROLE (PersonID, RoleID, RoleRef, BeginDate, ExpEndDate)
			values (
				@personID, 
				@roleID,
				concat(cast(floor(rand()*10) as nvarchar(1)), cast(floor(rand()*10) as nvarchar(1)), cast(floor(rand()*10) as nvarchar(1)), cast(floor(rand()*10) as nvarchar(1)), cast(floor(rand()*10) as nvarchar(1)), cast(floor(rand()*10) as nvarchar(1)), cast(floor(rand()*10) as nvarchar(1))),
				@begin,
				@enpEnd
			)
	end
	else if (@rand < 98) begin --make them a random staff
		set @begin = dateadd(day, -floor(rand()*730), cast(getdate() as date)) --random begin date from the last year
		set @roleID = (select RoleID from tblROLE where RoleName = 'UNDERGRADUATE')
		set @enpEnd = dateadd(day, (select default_term from tblROLE where RoleID = @roleID), @begin)
		insert into tblPERSON_ROLE (PersonID, RoleID, RoleRef, BeginDate, ExpEndDate)
			values (
				@personID, 
				@roleID,
				concat(cast(floor(rand()*10) as nvarchar(1)), cast(floor(rand()*10) as nvarchar(1)), cast(floor(rand()*10) as nvarchar(1)), cast(floor(rand()*10) as nvarchar(1)), cast(floor(rand()*10) as nvarchar(1)), cast(floor(rand()*10) as nvarchar(1)), cast(floor(rand()*10) as nvarchar(1))),
				@begin,
				@enpEnd
			)
	end
	else if (@rand < 99) begin --make them a rand visiting artist
		set @begin = dateadd(day, -floor(rand()*180), cast(getdate() as date)) --random begin date from the last year
		set @roleID = (select RoleID from tblROLE where RoleName = 'UNDERGRADUATE')
		set @enpEnd = dateadd(day, (select default_term from tblROLE where RoleID = @roleID), @begin)
		insert into tblPERSON_ROLE (PersonID, RoleID, RoleRef, BeginDate, ExpEndDate)
			values (
				@personID, 
				@roleID,
				concat(cast(floor(rand()*10) as nvarchar(1)), cast(floor(rand()*10) as nvarchar(1)), cast(floor(rand()*10) as nvarchar(1)), cast(floor(rand()*10) as nvarchar(1)), cast(floor(rand()*10) as nvarchar(1)), cast(floor(rand()*10) as nvarchar(1)), cast(floor(rand()*10) as nvarchar(1))),
				@begin,
				@enpEnd
			)
	end
set @personID = @PersonID + 1
end
commit tran T1