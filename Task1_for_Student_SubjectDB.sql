use school;

--Query #1: get the avg for all students with status 'Pass,Incomplete,Fail'
SELECT distinct 
s.student_id,
s.student_name,
(
select 
avg(grade) 
from student_subject ss9, students s9 
where ss9.student_Id=s.student_Id and ss9.student_Id = s9.student_Id
group by s9.student_id, s9.student_name
) as avga, 
case when 
(
select  
CASE WHEN (count(grade) =1 )
THEN  
'incomplete 1'
when(count(grade) =2)
then 'incomplete 2'
when(count(grade) >2)
then 'fail'

end 
from student_subject ss1,students s1 where ss1.student_Id=s1.student_Id and ss1.student_Id=ss.student_Id and   grade<50  
group by s1.student_id, s1.student_name
) 
is null then 'pass'
else (select  CASE 
WHEN (count(grade) =1 )
THEN  
'incomplete 1'
when(count(grade) =2)
then 'incomplete 2'
when(count(grade) >2)
then 'fail'

else  'pass'
end 
from student_subject ss1,students s1 where ss1.student_Id=s1.student_Id and ss1.student_Id=ss.student_Id and   grade<50  group by s1.student_id, s1.student_name)
end
as 'incomplete'
from students s join student_subject ss
on ss.student_id=s.student_id ;
         

--Query #2: get  the highest average of 3 students  provided that they are pass in all subjects
select top 3 s.student_id ,s.student_name   ,avg(grade) Average
from students s join student_subject ss
on s.student_Id=ss.student_Id   
group by s.student_id,s.student_name
having min(grade)>=50
order by avg(grade)desc;