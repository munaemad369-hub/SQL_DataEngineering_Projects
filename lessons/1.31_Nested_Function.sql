--Array 1 #################################################################################################
select ['Python', 'Sql','R'];


--Array #2
select 'Python' as Skill
union all
select 'Sql'
union all
select 'R';
--!then to make it like array need to use CTA..
with Skills as(
    select 'Python' as Skill
    union all
    select 'Sql'
    union all
    select 'R'
) 
--select Skill from Skills  ---> !use function ARRAY_AGG(..)  
/*  ┌─────────┐
    │  Skill  │
    │ varchar │
    ├─────────┤
    │ Python  │
    │ Sql     │
    │ R       │
    └─────────┘*/
select ARRAY_AGG(Skill) AS Skills from Skills;
/*
┌──────────────────┐
│ array_agg(Skill) │
│    varchar[]     │
├──────────────────┤
│ [R, Sql, Python] │
└──────────────────┘
*/
--------------------------------------------------
with Skills as(
    select 'Python' as Skill
    union all
    select 'Sql'
    union all
    select 'R'
), Skill_Array as(
    select 
        ARRAY_AGG(Skill order by Skill) AS Skills
    from 
        Skills
) 
select
 Skills[1]as first_skill , Skills[2] as second_skill,Skills[3] as third_skill
 from
  Skill_Array ;   

-- STRUCT  #################################################################################################
--#1
select {Skill:'python' , type:'Programming'} As Skill_Struct ;

--#2

select Struct_Pack(    ---> use Function STRUCT_PACK(..)
    Skill := 'python',
    type := 'programming '
) As S;
--............................
--with CTE..
with Skill_Struct as(
    select Struct_Pack(    
        Skill := 'python',
        type := 'programming '
    ) As S
)
select * 
from Skill_Struct;

select 'Python' as Skills , 'Programming' as types
    union all
    select 'Sql','quere language'
    union all
    select 'R', 'programming ';

/*
    ┌─────────┬────────────────┐
    │  Skill  │      type      │
    │ varchar │    varchar     │
    ├─────────┼────────────────┤
    │ Python  │ Programming    │
    │ Sql     │ quere language │
    │ R       │ programming    │
    └─────────┴────────────────┘
*/    
--......................
--with CTE + STRUCT
with Skill_table as(
    select 'Python' as Skills , 'Programming' as types
    union all
    select 'Sql','quere language'
    union all
    select 'R', 'programming '
) 
select 
    STRUCT_PACK(
        skill := Skills,
        type := types
    )
from 
    Skill_table;

--ARRAY OF STRUCT  #################################################################################################

select [
    {Skill:'Python', type:'Programming'},
    {Skill:'SQL', type:'quere language'}
] As Skills_Array_of_Struct;

--.........................    
with 
Skill_table as(
    select 'Python' as Skills , 'Programming' as types
    union all
    select 'Sql','quere language'
    union all
    select 'R', 'programming '
),
skill_array_struct as (
    select
        Array_AGG(
            STRUCT_PACK(              ---> Array_AGG(Struct_Pack())
                skill := Skills,
                type := types
            )
        ) as array_struct 
       from 
        Skill_table
)
select array_struct
from  skill_array_struct ;   
     

--MAP  #################################################################################################

select Map{'skill':'Python'};
--................
with Map_skill as(
    select Map{'skill':'Python', 'type':'Programming'} as Map_type
)
select 
    Map_type['type']
from    
    Map_skill   ; 

--JSON  #################################################################################################
 
 SELECT '{"skill":"python","type":"Programming"}':: JSON as skill_json;
--OR
SELECT TO_JSON('{"skill":"Python","type":"programming"}') as skill_json;

--..............
with raw_skill_json as(
    select '{"skill":"python","type":"programming"}':: Json as skill_json 
)
select 
    STRUCT_PACK(
        type := json_extract_string(skill_json,'$.type'),
        skill:= json_extract_string(skill_json , '$.skill')
    )
from 
    raw_skill_json;

--.....................

with raw_join as(
    SELECT
        '[
        {"skill":"python","type":"programming"},
        {"skill":"sql","type":"query_language"},
        {"skill":"r","type":"programming"}
    ]':: JSON AS skills_json
)
select 
Array_Agg(
    STRUCT_PACK(
        skill:=json_extract_string(e.value,'$.skill'),
        type:=json_extract_string(e.value,'$.type')
    )
 order by json_extract_string(e.value,'$.skill')
)as Skills
from raw_join , json_each(skills_json)as e;

