--Backet Salaries
-- <25 ='Low'
-- 25-58 ='Medium'
-- > 50 = 'High'
select 
 job_title_short,
 salary_hour_avg,
 case 
    when salary_hour_avg <25 then 'Low'
    when salary_hour_avg <50 then 'Meduim'
    --when salary_hour_avg >50 then 'High '
    else 'High' 
 end as Salary_Category
 from job_postings_fact
 where salary_hour_avg is not null 
 limit 10;


--Categorizing Categorical Values
--Classify the job_title' column values as:
    -- 'Data Analyst'
    -- 'Data Engineer'
    -- 'Data Scientist'
    
select 
  job_title,
  job_title_short,
  case 
    when job_title like '%Data%' and job_title  like '%Analyst%' then 'Data Analyst'
    when job_title like '%Data%' and job_title  like '%Engineer%' then 'Data Engineer'
    when job_title like '%Data%' and job_title  like '%Scientist%' then 'Data Scientist'
    else 'other '
    end as job_title_category
from job_postings_fact
order by random()
limit 20;


--Conditional Aggregation
-- Calculate Median Salaries for Different Buckets
--< $100K
-- >= $100K

select 
  job_title_short,
  count(*) as total_postings,
  median(
     case 
       when salary_year_avg <100_000 then salary_year_avg
     end
  ) as  Median_Low_Salary,
  median(
     case 
       when salary_year_avg >=100_000 then salary_year_avg
     end
  ) as  Median_High_Salary
  from job_postings_fact
  where salary_year_avg is not null
  group by job_title_short
  limit 20;


-- Final Example: Conditional Calculations
-- Compute a standardized_salary using yearly salary and adjusted hourly salary (e.g. 2080 hours/year)
-- Categorize salaries into tiers of:
-- < 75K 'Low'
-- 75K - 150K 'Medium'
-- >= 150K 'High'


with salaries as(
select 
 job_title_short,
 salary_hour_avg,
 salary_year_avg,
 case 
  when salary_year_avg is not null then salary_year_avg
  when salary_hour_avg is not null then salary_hour_avg*2080
 end as standardized_salary  
 from job_postings_fact
 where salary_year_avg is not null or salary_hour_avg is not null
)
select 
 *,
 case 
   when standardized_salary is null then 'missing ' 
   when standardized_salary<75_000 then 'Low'
   when standardized_salary <150_000 then 'Medium'
   else 'High '

 end as salary_buket
from salaries
order by standardized_salary asc
limit 10;