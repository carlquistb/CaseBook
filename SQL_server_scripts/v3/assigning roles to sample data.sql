--assign random roles to each sample person
declare @personID int = 1
while (exists (select * from tblPERSON where PersonID = @personID))
begin
	declare @rand int = floor(rand()*100) --random number 0-99
	if (@rand < 65) begin --make them a norm undergrad
		declare @begin date = dateadd(day, -floor(rand()*365), cast(getdate() as date)) --random begin date from the last year
		declare @roleID int = (select RoleID from tblROLE where RoleName = 'UNDERGRADUATE')
		declare @enpEnd date = dateadd(day, (select default_term from tblROLE where RoleID = @roleID), @begin)
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
	end
	else if (@rand < 85) begin -- make them a rand TA
	else if (@rand < 95) begin -- make them a random faculty
	end
	else if (@rand < 96) begin -- make them a random student staff
	end
	else if (@rand < 98) begin --make them a random staff
	end
	else if (@rand < 99) begin --make them a rand visiting artist
	end


@personID = @PersonID + 1
end

select * from tblROLE
