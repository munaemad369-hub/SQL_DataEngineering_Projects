select 
 jps.*,  --all column in this table 'job_postings_fact'
 cd.*
 from 
 job_postings_fact as jps left join company_dim as cd 
  on jps.company_id = cd.company_id
 limit 10; 



 select 
  jps.job_id ,
  jps.job_title_short,
  jps.company_id,
  cd.name as company_name
 from 
 job_postings_fact as jps left join company_dim as cd 
  on jps.company_id = cd.company_id;
-- limit 10; 

select count(*)  from job_postings_fact;

select 
  jps.job_id ,
  jps.job_title_short,
  jps.company_id,
  cd.name as company_name
 from 
 job_postings_fact as jps right join company_dim as cd 
  on jps.company_id = cd.company_id;


select 
  jps.job_id ,
  jps.job_title_short,
  jps.company_id,
  cd.name as company_name,
  jps.job_location
 from 
 job_postings_fact as jps full outer join company_dim as cd 
  on jps.company_id = cd.company_id;



select 
 jpf.job_id ,
 jpf.job_title_short ,
 sjd.skill_id ,
 sd.skills ,
from 
 job_postings_fact as jpf left join skills_job_dim as sjd
 on  jpf.job_id =sjd.job_id left join skills_dim as sd
 on sjd.skill_id=sd.skill_id
LIMIT 10 ;

select 
 cd.name as company_name,
 count(jpf.job_id)
from 
 job_postings_fact as jpf left join company_dim as cd 
 on jpf.company_id =cd.company_id 
 where jpf.country='united state'
 group by cd.name
 having count(jpf.job_id)>3000
 order by posting_count desc;

select jpf.* from job_postings_fact as jpf; 
select cd.* from company_dim as cd; 


explain analyze
select 
 cd.name as company_name,
 count(jpf.job_id)as posting_count
from 
 job_postings_fact as jpf left join company_dim as cd 
 on jpf.company_id =cd.company_id 
 where jpf.job_country='united state'
 group by cd.name
 having count(jpf.job_id)>3000
 order by posting_count desc
 limit 10;
