/*
Question: What are the highest-paying skills for data engineers?
- Calculate the median salary for each skill required in data engineer positions
- Focus on remote positions with specified salaries
- Include skill frequency to identify both salary and demand
- Why? Helps identify which skills command the highest compensation while also showing 
    how common those skills are, providing a more complete picture for skill development priorities
*/

select 

 count(*) as demand_count, --Include skill frequency to identify both salary and demand
 sd.skills,

 median(salary_year_avg) AS median_salary,    --round(median(salary_year_avg),0 ) AS median_salary,
 --median salary for each skill
from 
 job_postings_fact as jpf inner join skills_job_dim as sjd on jpf.job_id=sjd.job_id 
 inner join skills_dim as sd on sjd.skill_id =sd.skill_id

where 
 jpf.job_title_short ='Data Engineer' 
  -- required in data engineer positions
  and
 salary_year_avg is not null 
 --specified salaries

group by
 sd.skills
having 
 demand_count>100
order by  median_salary desc ;


