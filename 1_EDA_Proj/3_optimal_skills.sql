/*
Question: What are the most optimal skills for data engineers—balancing both demand and salary?
- Create a ranking column that combines demand count and median salary to identify the most valuable skills.
- Focus only on remote Data Engineer positions with specified annual salaries.
- Why?
    - This approach highlights skills that balance market demand and financial reward. 
    It weights core skills appropriately instead of letting rare, outlier skills distort the results.
    - The natural log transformation ensures that both high-salary and widely in-demand skills surface as the most practical 
    and valuable to learn for data engineering careers.
*/
select distinct job_title_short from job_postings_fact


select 
 count(*) as demand_count,
 sd.skills,
 round(median(salary_year_avg),0 ) AS median_salary,
 round(ln(demand_count),1) as ln_demand_count,
 round(ln(median_salary),2) as ln_median ,
 ln_demand_count +ln_median as ln_demand_median
from 
 job_postings_fact as jpf inner join skills_job_dim as sjd on jpf.job_id=sjd.job_id 
 inner join skills_dim as sd on sjd.skill_id =sd.skill_id
where 
 jpf.job_title_short ='Data Engineer' and
 salary_year_avg is not null
group by
 sd.skills
having 
 demand_count>100
order by  ln_demand_median desc
limit 10;



