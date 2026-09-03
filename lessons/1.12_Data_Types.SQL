
--1
select * 
from information_schema.columns ;

--2
select 
 table_name ,
 column_name,
 data_type 
from information_schema.columns 
where table_name='job_postings_fact';

--3 
Describe job_postings_fact;
--or
describe                          
 select 
  job_title_short,
  salary_year_avg
 from job_postings_fact;  
 /*
  Data Type of Column 
┌─────────────────────────┐
│    job_postings_fact    │
│                         │
│ job_title_short varchar │
│ salary_year_avg double  │
└─────────────────────────┘
 */

 --4 CASTING 

 select cast(123 as varchar);
 /*
┌──────────────────────┐
│ CAST(123 AS VARCHAR) │
│       varchar        │
├──────────────────────┤
│ 123                  │
└──────────────────────┘
 */


select
 cast(job_id as varchar)/*job_id*/||'-'|| cast(company_id as varchar), --company_id,
 job_title_short,
 cast(job_work_from_home as int),--job_work_from_home,
 cast(salary_year_avg as decimal(10,0)),--salary_year_avg,
 cast(job_posted_date as date)--job_posted_date
from job_postings_fact
where salary_year_avg is not null
limit 10;