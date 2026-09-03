create or replace table staging.priority_roles(
    role_id int primary key ,
    role_name varchar(50),
    priority_lvl int 
);
insert into staging.priority_roles
values (1 , 'Data Engineer', 1),
       (2 ,'senior Data Engineer',2),
       (3 ,'Data analyst',2),
       (4 , 'Software Engineer' , 3);

select * from staging.priority_roles;       


create or replace table main.priority_jobs_snapshot (
    job_id int primary key ,
    job_title_short varchar,
    company_name varchar ,
    job_posted_date timestamp,
    salary_year_avg Double,
    priority_lvl int ,
    update_at timestamp);
insert into  main.priority_jobs_snapshot(
    job_id  ,
    job_title_short ,
    company_name  ,
    job_posted_date ,
    salary_year_avg ,
    priority_lvl  ,
    update_at 
)
select 
 jpf.job_id,
 jpf.job_title_short,
 cd.name as company_name,
 jpf.job_posted_date,
 jpf.salary_year_avg,
 r.role_lvl,
 current_timestamp
from 
data_jobs.job_postings_fact as jpf left join data_jobs.company_dim as cd
 on jpf.company_id = cd.company_id inner join staging.priority_roles as r on r.role_name = jpf.job_title_short;

select 
 job_title_short,
 count(*) as job_count,
 min(priority_lvl) as priority_lvl,
 min(update_at) as updated_at
from priority_jobs_snapshot
group by job_title_short;     

