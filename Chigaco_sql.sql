Select Location_Description
from Crimes_2001_to_Present
where Location_Description like '%school%'

Select *
from census_data

Select *
from chicago_public_schools

*** Q1  list the school names, community names and average attendance for communities with a hardship index of 98

Select 
   p.Name_of_school, 
   p.community_area_name,
   p.community_area_number,
   p.average_teacher_attendance,
   p.average_teacher_attendance,
   c.hardship_index

From
   chicago_public_schools p Left join census_data c 
on 
   p.community_area_number = c.Community_Area_Number

 
where
   hardship_index = 98

***Q2 list all crimes that took place at a school. Include case number, crime type and community name

Select 
  c.case_number, 
  c.description crime_type,
  cast(c.community_area as float) community_area_number, 
  p.community_area_name,
  cast(c.location_description as nvarchar(255)) crime_place

From
  Crimes_2001_to_Present c left join census_data p
on 
  cast(c.community_area as float) = p.community_area_number
Where
  Location_Description like '%school%'
  
*** Q3  SQL statement to create a view 

Create View pubic_school_rating (school_name, safety_rating, family_rating, environment_rating, instruction_rating,leader_rating) 
 as select name_of_school,safety_icon, family_involvement_icon, environment_icon, instruction_icon, leaders_icon
From chicago_public_schools

Select *
From pubic_school_rating

***Q4 create procedures

Create Proc update_leaders_score ( 
   @leaders_store as int,
   @school_id as int
   )
As
    If @leaders_store > 0 AND @leaders_store < 20
	   Begin 
	     update chicago_public_schools
		 set leader_icon = 'very weak'
		 where school_id =@school_id 
      End

alter Proc update_leaders_score ( 
   @leaders_store as int,
   @school_id as int
   )
As
Begin
    If @leaders_store > 0 AND @leaders_store < 20
	   Begin 
	     update Chicago_crime.dbo.Chicago_Public_Schools
		 set leaders_icon = 'very weak'
		 where school_id =@school_id 
      End
   If @leaders_store> 20 AND @leaders_store < 40
	   Begin 
	     update Chicago_crime.dbo.Chicago_Public_Schools
		 set leaders_icon = 'weak'
		 where school_id =@school_id 
      End
  If @leaders_store> 40 AND @leaders_store < 60
	   Begin 
	     update Chicago_crime.dbo.Chicago_Public_Schools
		 set leaders_icon = 'average'
		 where school_id =@school_id 
      End
 If  @leaders_store> 60 AND @leaders_store < 80
	   Begin 
	     update Chicago_crime.dbo.Chicago_Public_Schools
		 set [Leaders_Icon ] = 'strong'
		 where school_id =@school_id 
      End
  If  @leaders_store> 80 AND @leaders_store < 100
	   Begin 
	     update Chicago_crime.dbo.Chicago_Public_Schools
		 set [Leaders_Icon ] = 'very strong'
		 where school_id =@school_id 
      End
End

exec update_leaders_score @school_id = 610239, @leaders_store = 59

select school_id, Name_of_School, leaders_icon, leaders_score
from Chicago_crime.dbo.Chicago_Public_Schools
where school_id = 610239