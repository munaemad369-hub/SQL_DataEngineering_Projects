use data_jobs;
create database if not exists jobs_mart;

show databases;

--drop database if exists jobs_mart;

select *
from information_schema.schemata;

use jobs_mart;
create schema if not exists staging;

--drop table if exists staging.preferred_roles;

create table if not exists staging.preferred_roles(
    role_id int primary key,
    role_name varchar(30)
);

insert into staging.preferred_roles(role_id, role_name)
values (1, 'Data Engineer'),
       (2, 'Senior Data Engineer'),
       (3, 'Software Engineer');

select * from staging.preferred_roles;

alter table staging.preferred_roles
add column preferred_role boolean;

update staging.preferred_roles
set preferred_role = True
where role_id = 2 or role_id = 1;

update staging.preferred_roles
set preferred_role = false
where role_id = 3;

alter table staging.preferred_roles
rename TO priority_roles;

select * from staging.priority_roles;

alter table staging.priority_roles
rename column preferred_role to priority_lvl;

alter table staging.priority_roles
alter column priority_lvl type int;

update staging.priority_roles
set priority_lvl = 3
where role_id = 3;

select * from staging.priority_roles;
