-- Windo Function
/*

Row & Rank:

ROW_NUMBER → رقم فريد لكل row

RANK       → ترتيب + نفس الرقم عند التعادل + gap

DENSE_RANK → ترتيب + نفس الرقم عند التعادل + gap بدون

PERCENT_RANK → موقع نسبي من 0 إلى 1

NTILE      → تقسيم الصفوف إلى مجموعات
-------------------------------------------------------

Navigation:

LAG         → الصف السابق
LEAD        → الصف التالي
FIRST_VALUE → أول قيمة
LAST_VALUE  → آخر قيمة
NTH_VALUE   → القيمة رقم N

*/


select 
  job_id,
  job_title_short,
  company_id,
  salary_hour_avg,
  avg(salary_hour_avg) over(partition by job_title_short,
  company_id)
from job_postings_fact
where salary_hour_avg is not null
order by random()
limit 20;  
 


select 
  job_id,
  job_title_short,
  salary_hour_avg,
  Rank() over(order by salary_hour_avg asc ) as Rank_salary_Hour
from 
  job_postings_fact
where 
  salary_hour_avg is not null
order by 
  Rank_salary_Hour asc
limit 20;  


select 
  job_posted_date ,
  job_title_short,
  company_id,
  salary_hour_avg,

  avg(salary_hour_avg) over(
    partition by job_title_short 
    order by job_posted_date 
  )as running_avg_hourly_by_title

from 
  job_postings_fact
where 
  salary_hour_avg is not null
order by 
  job_title_short,
  job_posted_date
limit 20;  


select 
  job_id,
  job_title_short,
  salary_hour_avg,

  RANK() over(        --->  ..DENCE_RANK
    partition by job_title_short 
    order by salary_hour_avg desc
  )as Rank_hourly_salary 
  
from 
  job_postings_fact
where 
  salary_hour_avg is not null
order by 
  salary_hour_avg desc,
  job_title_short
limit 20;  



select 
  job_posted_date ,
  job_title_short,
  company_id,
  salary_hour_avg,

  avg(salary_hour_avg) over(  --->MAX()..MIN()..SUM() 
    partition by job_title_short 
    order by job_posted_date 
  )as running_avg_hourly_by_title

from 
  job_postings_fact
where 
  salary_hour_avg is not null
  job_title_short ='Data Engineer '
order by 
  job_title_short,
  job_posted_date
limit 20; 

SELECT 
    job_id,
    company_id,
    job_title_short,
    job_title,
    job_posted_date,
    salary_year_avg,

    LAG(salary_year_avg) OVER (
        PARTITION BY company_id
        ORDER BY job_posted_date
    ) AS previous_posting_salary,

    salary_year_avg 
    - LAG(salary_year_avg) OVER (
        PARTITION BY company_id
        ORDER BY job_posted_date
    ) AS salary_change

FROM job_postings_fact

WHERE salary_year_avg IS NOT NULL

ORDER BY
    company_id,
    job_posted_date

LIMIT 60;
