select [1,1,1,2];

select unnest([1,1,1,2]);
----------------------------------------
select unnest([1,1,1,2]) --A
UNION --OR UNION ALL
select unnest([1,1,3]);--B

select unnest([1,1,1,2]) --A
intersect -- OR INTERSECT ALL
select unnest([1,1,3]);--B

select unnest([1,1,1,2]) --A
EXCEPT -- OR EXCEPT ALL
select unnest([1,1,3]);--B
---------------------------------------------


--CTAs
create temp table jobs_2023 as 
select * Exclude (job_id,job_posted_date )
from job_postings_fact
where EXTRACT(year from job_posted_date)=2023;

select * from jobs_2023;
---------------------------------------------
create temp table jobs_2024 as 
select * Exclude (job_id,job_posted_date )
from job_postings_fact
where EXTRACT(year from job_posted_date)=2024;

select * from jobs_2024;

-- Which unique job postings appeared in either 2023 or 2024?
select * from jobs_2023
UNION
select * from jobs_2024;
                   -------------------

select 
    'jobs_2023' as table_name ,
    count(*)
from jobs_2023
UNION
select
    'jobs_2024' as table_name ,
    count(*)
from jobs_2024;

-- Which job postings appeared across both years, counting duplicates?
select * from jobs_2023
UNION ALL
select * from jobs_2024;

-- Which job postings appeared in 2023 but not in 2024?
select * from jobs_2023
EXCEPT
select * from jobs_2024;

-- Which job postings from 2023 remain after subtracting matching 2024 postings, one-for-one?
select * from jobs_2023
EXCEPT ALL
select * from jobs_2024;

-- Which job postings appeared in both 2023 and 2024?
select * from jobs_2023
INTERSECT
select * from jobs_2024;

-- Which job postings appeared in both years, preserving duplicate counts?
select * from jobs_2023
INTERSECT ALL
select * from jobs_2024;