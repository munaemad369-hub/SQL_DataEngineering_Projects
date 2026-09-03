select 
    job_posted_date,
    job_posted_date::Date as Date ,
     job_posted_date:: Time as Time,
    job_posted_date:: timestamp as timestamp,
     job_posted_date:: timestampTZ as timestampTZ
from job_postings_fact
limit 10;
---------------------------------------------------------------------------

--#EXTRACT
SELECT 
    job_posted_date,
    EXTRACT(year from job_posted_date) as job_posted_date
from job_postings_fact
limit 10;
----------------------------------------------------------------

SELECT 
    EXTRACT(year from job_posted_date) as job_posted_year,
    EXTRACT(month from job_posted_date) as job_posted_month,
    count(job_id) as job_count 
from job_postings_fact
where job_title_short='Data Engineer'
group by 
    EXTRACT(year from job_posted_date)  ,
    EXTRACT(month from job_posted_date) 
limit 10;


--##DATE_TRUNC
select 
  job_posted_date
  DATE_TRUNC('MONTH', job_posted_date)
from job_postings_fact
order by random()
limit 10;  
---------------------------------------------------------------

select 
    job_posted_date,
    DATE_TRUNC('year',job_posted_date)as truncated_year  ,
    DATE_TRUNC('quarter',job_posted_date)as truncated_quarter  ,
    DATE_TRUNC('month',job_posted_date)as truncated_month  ,
    DATE_TRUNC('week',job_posted_date)as truncated_week  ,
    DATE_TRUNC('day',job_posted_date)as truncated_day  ,
    DATE_TRUNC('hour',job_posted_date)as truncated_hour  ,
from job_postings_fact
order by random()
limit 10;    

-------------------------------------------------------------------

select 
    DATE_TRUNC('month',job_posted_date) as job_posted_month,
    count(job_id) as job_count
from job_postings_fact
where job_title_short='Data Engineer'and 
      DATE_TRUNC('year',job_posted_date)='2024-01-01'
    --or EXTRACT(year from job_posted_date) =2024
group by 
     DATE_TRUNC('month',job_posted_date)   
order by job_posted_month ;     


--###AT TIME ZONE

select 
    job_posted_date at time zone 'UTC'
from
    job_postings_fact
limit 10 ;    
------------------------------------------------

select 
    job_title_short,
    job_location,
    job_posted_date at time zone 'EST'
from 
    job_postings_fact
where 
    job_location like '% New York , NY %';
----------------------------------------------------

select 
    
    EXTRACT(HOUR FROM job_posted_date at time zone 'EST') as job_posted_hour ,
    count(job_id ) as job_count
from 
    job_postings_fact
where 
    job_location like '% New York , NY %';
group by  
   EXTRACT(HOUR FROM job_posted_date at time zone 'EST')



