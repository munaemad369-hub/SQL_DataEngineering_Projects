
 show all tables; --command
 /*┌───────────────────────┬──────────────────────┬──────────────────────┬──────────────────────────────┬───────────────────────────────┬───────────┐
│       database        │        schema        │         name         │         column_names         │         column_types          │ temporary │
│        varchar        │       varchar        │       varchar        │          varchar[]           │           varchar[]           │  boolean  │
├───────────────────────┼──────────────────────┼──────────────────────┼──────────────────────────────┼───────────────────────────────┼───────────┤
│ data_jobs             │ main                 │ company_dim          │ [company_id, name, link, li… │ [INTEGER, VARCHAR, VARCHAR, … │ false     │
│ data_jobs             │ main                 │ job_postings_fact    │ [job_id, company_id, job_ti… │ [INTEGER, INTEGER, VARCHAR, … │ false     │
│ data_jobs             │ main                 │ skills_dim           │ [skill_id, skills, type]     │ [INTEGER, VARCHAR, VARCHAR]   │ false     │
│ data_jobs             │ main                 │ skills_job_dim       │ [skill_id, job_id]           │ [INTEGER, INTEGER]            │ false     │
│ md_information_schema │ main                 │ database_snapshots   │ [database_name, database_id… │ [VARCHAR, UUID, UUID, VARCHA… │ false     │
│ md_information_schema │ main                 │ databases            │ [name, uuid, created_ts, tr… │ [VARCHAR, UUID, TIMESTAMP WI… │ false     │
│ md_information_schema │ main                 │ owned_shares         │ [name, url, source_db_name,… │ [VARCHAR, VARCHAR, VARCHAR, … │ false     │
│ md_information_schema │ main                 │ query_history        │ [query_id, query_text, star… │ [UUID, VARCHAR, TIMESTAMP WI… │ false     │
│ md_information_schema │ main                 │ recent_queries       │ [query_id, query_text, star… │ [UUID, VARCHAR, TIMESTAMP WI… │ false     │
│ md_information_schema │ main                 │ roles                │ [role_name, role_type, incl… │ [VARCHAR, VARCHAR, 'VARCHAR[… │ false     │
│ md_information_schema │ main                 │ shared_with_me       │ [name, url, owner, visibili… │ [VARCHAR, VARCHAR, VARCHAR, … │ false     │
│ md_information_schema │ main                 │ storage_info         │ [database_name, database_id… │ [VARCHAR, UUID, TIMESTAMP_S,… │ false     │
│ md_information_schema │ main                 │ storage_info_history │ [database_name, database_id… │ [VARCHAR, UUID, TIMESTAMP_S,… │ false     │
│ sample_data           │ hn                   │ hacker_news          │ [title, url, text, dead, by… │ [VARCHAR, VARCHAR, VARCHAR, … │ false     │
│ sample_data           │ kaggle               │ movies               │ [overview, title, overview_… │ [VARCHAR, VARCHAR, 'FLOAT[51… │ false     │
│ sample_data           │ nyc                  │ rideshare            │ [hvfhs_license_num, dispatc… │ [VARCHAR, VARCHAR, VARCHAR, … │ false     │
│ sample_data           │ nyc                  │ service_requests     │ [unique_key, created_date, … │ [BIGINT, TIMESTAMP, TIMESTAM… │ false     │
│ sample_data           │ nyc                  │ taxi                 │ [VendorID, tpep_pickup_date… │ [BIGINT, TIMESTAMP, TIMESTAM… │ false     │
│ sample_data           │ stackoverflow_survey │ survey_results       │ [Respondent, Professional, … │ [BIGINT, VARCHAR, VARCHAR, V… │ false     │
│ sample_data           │ stackoverflow_survey │ survey_schemas       │ [qname, question, qid, forc… │ [VARCHAR, VARCHAR, VARCHAR, … │ false     │
│ sample_data           │ who                  │ ambient_air_quality  │ [who_region, iso3, country_… │ [VARCHAR, VARCHAR, VARCHAR, … │ false     │
└───────────────────────┴──────────────────────┴──────────────────────┴──────────────────────────────┴───────────────────────────────┴───────────┘*/


select distinct * from job_postings_fact;
/*────────┬────────────┬──────────────────────┬──────────────────────┬───┬──────────────────────┬─────────────┬─────────────────┬─────────────────┐
│ job_id │ company_id │   job_title_short    │      job_title       │ … │     job_country      │ salary_rate │ salary_year_avg │ salary_hour_avg │
│ int32  │   int32    │       varchar        │       varchar        │ … │       varchar        │   varchar   │     double      │     double      │
├────────┼────────────┼──────────────────────┼──────────────────────┼───┼──────────────────────┼─────────────┼─────────────────┼─────────────────┤
│ 250360 │      12264 │ Data Analyst         │ Research Data Analy… │ … │ United States        │ NULL        │            NULL │            NULL │
│ 250362 │      11951 │ Data Analyst         │ Quality Data Analys… │ … │ United States        │ NULL        │            NULL │            NULL │
│ 250382 │       6025 │ Data Analyst         │ Oracle Fusion Data … │ … │ United States        │ NULL        │            NULL │            NULL │
│ 250388 │     242970 │ Data Scientist       │ Data Scientist - NLP │ … │ United States        │ NULL        │            NULL │            NULL │
│ 250457 │     250457 │ Data Engineer        │ Director, Data Engi… │ … │ United States        │ NULL        │            NULL │            NULL │
│ 250461 │      12732 │ Data Analyst         │ Data Analyst Intern  │ … │ Sweden               │ NULL        │            NULL │            NULL │
│ 250476 │      38803 │ Senior Data Analyst  │ Senior Data Analyst… │ … │ Germany              │ NULL        │            NULL │            NULL │
│ 250479 │      11124 │ Data Engineer        │ Data Engineering Ma… │ … │ Spain                │ NULL        │            NULL │            NULL │
│ 250549 │       5776 │ Data Scientist       │ Data Scientist       │ … │ United States        │ NULL        │            NULL │            NULL │
│ 250604 │     218374 │ Data Scientist       │ Data Analyst, Data … │ … │ Singapore            │ NULL        │            NULL │            NULL │
│ 250612 │     235452 │ Senior Data Engineer │ Senior Data Engineer │ … │ Singapore            │ NULL        │            NULL │            NULL │
│ 250626 │      44752 │ Senior Data Engineer │ Senior / Field Syst… │ … │ Singapore            │ NULL        │            NULL │            NULL │
│ 250634 │     250634 │ Business Analyst     │ Junior Business Ana… │ … │ Czechia              │ NULL        │            NULL │            NULL │
│ 250645 │     131738 │ Machine Learning En… │ IAM Engineer         │ … │ Ireland              │ NULL        │            NULL │            NULL │
│ 250655 │     190976 │ Senior Data Scienti… │ Senior Data Scienti… │ … │ India                │ NULL        │            NULL │            NULL │
│ 250808 │      77773 │ Data Engineer        │ Dataingenjör         │ … │ Sweden               │ NULL        │            NULL │            NULL │
│ 250911 │       8637 │ Data Engineer        │ Snowflake Data Engi… │ … │ United States        │ hour        │            NULL │            10.0 │
│ 250914 │      10548 │ Data Engineer        │ Data Engineer III    │ … │ United States        │ NULL        │            NULL │            NULL │
│ 250967 │     250967 │ Data Scientist       │ Data Scientist       │ … │ India                │ NULL        │            NULL │            NULL │
│ 250975 │       8226 │ Senior Data Analyst  │ Senior PIM Data Ana… │ … │ Canada               │ NULL        │            NULL │            NULL │
│    ·   │         ·  │          ·           │          ·           │ … │ ·                    │  ·          │              ·  │              ·  │
│    ·   │         ·  │          ·           │          ·           │ … │ ·                    │  ·          │              ·  │              ·  │
│    ·   │         ·  │          ·           │          ·           │ … │ ·                    │  ·          │              ·  │              ·  │
│ 471023 │     212463 │ Machine Learning En… │ Machine Learning Ar… │ … │ Argentina            │ NULL        │            NULL │            NULL │
│ 471048 │     212463 │ Software Engineer    │ Application Support… │ … │ Argentina            │ NULL        │            NULL │            NULL │
│ 471097 │      28232 │ Business Analyst     │ Marketing Analytics  │ … │ Italy                │ NULL        │            NULL │            NULL │
│ 471118 │      14690 │ Data Analyst         │ Data Analyst         │ … │ South Africa         │ NULL        │            NULL │            NULL │
│ 471166 │      19810 │ Data Analyst         │ Data Analyst         │ … │ Spain                │ NULL        │            NULL │            NULL │
│ 471179 │      22248 │ Data Analyst         │ Data Center Analyst  │ … │ Spain                │ NULL        │            NULL │            NULL │
│ 471242 │       6213 │ Data Engineer        │ Junior Data Engineer │ … │ Poland               │ NULL        │            NULL │            NULL │
│ 471253 │     245938 │ Data Analyst         │ Data Analyst Officer │ … │ United Arab Emirates │ NULL        │            NULL │            NULL │
│ 471256 │     131173 │ Data Analyst         │ Junior Data Analyst  │ … │ United Arab Emirates │ NULL        │            NULL │            NULL │
│ 471289 │     471289 │ Business Analyst     │ Marketing Analyst    │ … │ Singapore            │ NULL        │            NULL │            NULL │
│ 471366 │     471366 │ Software Engineer    │ Senior Software Eng… │ … │ Italy                │ NULL        │            NULL │            NULL │
│ 471378 │      45269 │ Data Analyst         │ Permanent - Master … │ … │ France               │ NULL        │            NULL │            NULL │
│ 471426 │      68864 │ Data Engineer        │ Data Engineer        │ … │ Sudan                │ NULL        │            NULL │            NULL │
│ 471489 │       5424 │ Cloud Engineer       │ Customer Success En… │ … │ Saudi Arabia         │ NULL        │            NULL │            NULL │
│ 471585 │      33906 │ Data Scientist       │ Analytics Engineer   │ … │ United States        │ NULL        │            NULL │            NULL │
│ 471608 │      16169 │ Software Engineer    │ DevOps Engineer      │ … │ South Africa         │ NULL        │            NULL │            NULL │
│ 471719 │       6127 │ Data Analyst         │ Sr Data Analyst      │ … │ Switzerland          │ NULL        │            NULL │            NULL │
│ 471722 │      91412 │ Data Analyst         │ Business / Data Ana… │ … │ Morocco              │ NULL        │            NULL │            NULL │
│ 471748 │      39691 │ Data Engineer        │ Data Engineer        │ … │ Portugal             │ NULL        │            NULL │            NULL │
│ 471776 │     471776 │ Business Analyst     │ Senior Marketing An… │ … │ United States        │ NULL        │            NULL │            NULL │
└────────┴────────────┴──────────────────────┴──────────────────────┴───┴──────────────────────┴─────────────┴─────────────────┴─────────────────┘*/



/*
Question: What are the most in-demand skills for data engineers?
- Join job postings to inner join table similar to query 2
- Identify the top 10 in-demand skills for data engineers
- Focus on remote job postings
- Why? Retrieves the top 10 skills with the highest demand in the remote job market,
    providing insights into the most valuable skills for data engineers seeking remote work
*/

select  
count(*) as demand_count,
sd.skills
--in-demand skills

from 
job_postings_fact as jpf inner join skills_job_dim as sjd on jpf.job_id = sjd.job_id 
inner join skills_dim as sd on sjd.skill_id=sd.skill_id
--Join job postings to inner join table similar to query 2

where jpf.job_title_short='Data Engineer' 
--for data engineers

group by sd.skills   
--most in-demand  'group by' + 'couont'  

order by demand_count desc

limit 10; 
--top 10 +'order by'

/*
┌──────────────┬────────────┐
│ demand_count │   skills   │
│    int64     │  varchar   │
├──────────────┼────────────┤
│       233132 │ sql        │
│       224102 │ python     │
│       130205 │ aws        │
│       128822 │ azure      │
│       106904 │ spark      │
│        69657 │ java       │
│        63012 │ databricks │
│        60379 │ snowflake  │
│        57079 │ scala      │
│        56410 │ kafka      │
└──────────────┴────────────┘*/