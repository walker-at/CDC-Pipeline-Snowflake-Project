create database if not exists scd_demo;
use database scd_demo;
create schema if not exists scd2;
use schema scd2;
show tables;

create or replace table customer (
     customer_id number,
     first_name varchar,
     last_name varchar,
     email varchar,
     street varchar,
     city varchar,
     state varchar,
     country varchar,
     update_timestamp timestamp_ntz default current_timestamp()); -- will keep track of each update made to customer table

create or replace table customer_history (
     customer_id number,
     first_name varchar,
     last_name varchar,
     email varchar,
     street varchar,
     city varchar,
     state varchar,
     country varchar,
     start_time timestamp_ntz default current_timestamp(),
     end_time timestamp_ntz default current_timestamp(),
     is_current boolean -- make sure the whole update history is stored here
     );

-- whenever new data is availble, data is first loaded here, our staging table. snowflake stream and task will update our customer and customer history tables
create or replace table customer_raw (
     customer_id number,
     first_name varchar,
     last_name varchar,
     email varchar,
     street varchar,
     city varchar,
     state varchar,
     country varchar);

-- stream will keep track of all changes to the customer table so we can update customer_history
create or replace stream customer_table_changes on table customer;
