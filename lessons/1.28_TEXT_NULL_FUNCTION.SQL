SELECT Length('AQL'); --OR SELECT CHAR_LENGTH('SQL');

SELECT UPPER('sql');
select lower('SQL');

SELECT LEFT('SQL',2);
SELECT RIGHT('SQL',2);
SELECT SUBSTRING('SQL',2,1);

SELECT CONCAT('SQL','-','FUNCTION'); --OR SELECT 'SQL' ||'-'||'FUNCTION';

SELECT TRIM(' SQL ');
SELECT LTRIM(' SQL ');
SELECT RTRIM(' SQL ');

SELECT REPLACE ('SQL','Q','A');

SELECT REGEXP_REPLACE('data.nerd@gmail.com','^.*(@)','\1'); -- Need GPT!


--Final Example -cleanup this using Text Functions


with job_lower as (
  select 
    job_title,
    lower(trim(job_title)) as job_title_cleaning 
  from job_postings_fact
)
select 
  job_title,
  case 
    when job_title_cleaning like '%data%' and job_title_cleaning like '%analyst%' then 'Data Analyst'
    when job_title_cleaning like '%data%' and job_title_cleaning like '%engineer%' then 'Data Engineer'
    when job_title_cleaning like '%data%' and job_title_cleaning like '%scientist%' then 'Data Scientist'
    else 'Other'
  end as job_title_category
from job_lower
order by random()
limit 30;


