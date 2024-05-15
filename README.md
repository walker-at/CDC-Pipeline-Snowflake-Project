# CDC Pipeline in Snowflake Project

This pipeline simulates the real-time ingestion of streaming data. The pipeline is fed customer data generated within a jupyter notebook, processes and routes it with Apache NiFi to an Amazon S3 bucket, and loads it into a staging table in Snowflake called "customer_raw". Once in Snowflake, there are 2 target tables to send our data to: the first, called "customer,"  will contain the most up to date customer information, and the second, called "customer_history," will contain the historical customer information. 

I create a Snowflake Stream to capture any changes in our staging table (the inserts, deletes, or updates), and I wrap this stream in a Snowflake Task in order to automate the data ingestion process at 1min intervals. In the end, we have a pipeline which implements Type 1 and Type 2 Slowly Changing Dimensions (SCD). The "customer" table only receives new customer data; in other words, it overwrites existing customer data (SCD 1). The "customer_history" table maintains past customer data by adding a date range column for each entry ('start_time' & 'end_time') and by including a flag column ('is_current'). 

# Project Tools
Raw Data Generation
  * Python - specifically the faker library

Cloud
  * AWS EC2 instance - I deployed Apache NiFi onto an EC2 instance using docker
  * Amazon S3 bucket - receives data from Apache NiFi for ingestion by snowpipe

ETL
  * Apache NiFi - to push generated data into our S3 bucket
  * Snowpipe - for integration from S3 into Snowflake (triggers whenever a new file is added to the S3 bucket)
  * Snowflake Stream & Task - to automate our pipeline in order to simulate the handling of a continous data flow.

# Workflow
python code runs & data gets stored on EC2 machine -> Apache NiFi will reroute the data to an Amazon S3 bucket -> Snowpipe is triggered to load this data onto the staging table -> (CDC) A Snowflake Stream wrapped in a Snowflake Task -> inserting new data and updating old data in our first target table (SCD 1), keeping track of historical records in our second target table (SCD 2)

# Apache NiFi
Apache nifi is a web-based interface for designing and monitoring data flows. I chose NiFi over airflow because this project is simulating a continuous data flow and so deals with stream processing. The first screenshot below is the process group for this project.
![NIFI1](https://github.com/walker-at/Snowflake-DE-Project/assets/161479815/3ffc4314-c01e-4132-b798-a68f68133248)
The next screenshot goes within this process group, showing the 3 processors that fetch the newly generated file and reroute it to an aws s3 bucket, along with the 2 connections linking these processor nodes together.
![NIFI2](https://github.com/walker-at/Snowflake-DE-Project/assets/161479815/ff6e4102-4ad6-4aca-800e-2aad6dc900bf)

