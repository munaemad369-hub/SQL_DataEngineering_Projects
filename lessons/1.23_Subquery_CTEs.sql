-- SUBQUERY
select *
from  (select *
      from job_postings_fact 
      where salary_year_avg is not null or
            salary_hour_avg is not null ) as asvalid_salaries 
limit 10;      

--CTE
WITH valid_salaries as  (SELECT *
      FROM job_postings_fact
      where salary_year_avg is not null or
            salary_hour_avg is not null )
SELECT *
FROM job_postings_fact
limit 10;


-- Scenario 1 - Subquery in SELECT'
-- Show each job's salary next to the overall market median:

select 
 job_title_short,
 salary_year_avg,
 (select median(salary_year_avg)
 from job_postings_fact  ) as market_median  -->Subquery بالـ SELECT = "احسبيلي رقم مرجعي ثابت أقارن فيه كل صف".

from job_postings_fact   
where salary_year_avg is not null
limit 10;   

-- * Scenario 2 - Subquery in FROM
-- Stage only jobs that are remote before aggregating:

select 
 job_title_short,
 median(salary_year_avg),
 (select median(salary_year_avg)
 from job_postings_fact  ) as market_median 

from (   
 select 
   job_title_short,
   salary_year_avg
   from job_postings_fact
   where job_work_from_home =true
)  as clean_jobs                     --> Subquery بالـ FROM = "جهزيلي جدول أنظف أشتغل عليه".

where salary_year_avg is not null
group by job_title_short
order by median(salary_year_avg) desc
limit 10; 

-- Scenario 3 - Subquery in'HAVING
-- Keep only job titles whose median salary is above the overall median:

select 
 job_title_short,
 median(salary_year_avg) as median_salary,
 (select median(salary_year_avg)
 from job_postings_fact 
 where job_work_from_home =true ) as market_remote_median_salary 

from (   
 select 
   job_title_short,
   salary_year_avg
   from job_postings_fact
   where job_work_from_home =true
)  as clean_jobs  

where salary_year_avg is not null
group by job_title_short 
HAVING median(salary_year_avg)>(select median(salary_year_avg)
                                from job_postings_fact
                                where job_work_from_home=true)
order by median(salary_year_avg) desc
limit 10; 


-- CTE Example
-- Compare how much more (or less) remote roles pay compared to onsite roles for each job title.
-- Use a CTE to calculate the median salary by title and work arrangement, then compare those medians.

with title_median as (
      select
      job_title_short,
      median(salary_year_avg)::int as median_salary,
      job_work_from_home
      from job_postings_fact
      where job_country='United States'
      group by job_title_short , job_work_from_home)
select 
 r.job_title_short,
 r.median_salary as remote_median_salary,
 o.median_salary as onsite_median_salary,
(r.median_salary - o.median_salary) as remote_premium
from title_median as r inner join title_median as o
 on r.job_title_short = o.job_title_short
where r.job_work_from_home = true and o.job_work_from_home = false
order by remote_premium desc;



select range(10) ;

select * 
from range (3) as src(key);

select *
from range(2) as tgt(key);

select *
from range (3) as src(key)
where exists (
      select 1
      from range(2) as tgt(key)
      where tgt.key = src.key );

select *
from range (3) as src(key)
where not exists(
      select 1
      from range(2) as tgt(key)
      where tgt.key=src.key
);


-- Final Example
-- Identify job postings that have no associated skills before loading them into a data mart
SELECT *
FROM job_postings_fact
ORDER BY job_id
LIMIT 10;

SELECT *
FROM skills_job_dim
ORDER BY job_id
LIMIT 40;

SELECT *
FROM job_postings_fact AS tgt
WHERE NOT EXISTS(
SELECT 1
FROM skills_job_dim AS src
WHERE tgt.job_id =src.job_id)
order by job_id;
              