# Snowflake-DE-Project
Deployed Apache NiFi onto an EC2 instance (using docker?)
instead of installing all of these thing sindividually i use a docker image 

generate test data with python code, to simulate real-time data streaming in action. most api's for real time data are paid. the library faker we use for random data. whenever data is generated it is uploaded to amazon s3 using APache NiFi
configured a snowpipe to trigger whenevr a new file is added to the s3 bucket

python code runs & data gets stored on EC2 machine -> Apache NiFi will reroute the data to an Amazon S3 bucket -> Snowpipe is triggered to load this data onto the staging table, storing the raw data as it is -> (CDC) A Snowflake Stream tracking any changes in our staging table is wrapped in a Snowflake Task in order to automate the stream at 1min intervals, inserting new data and updating old data in our first target table (SCD 1), keeping track of historical records (SCD 2)

first table - staging/raw
second - actual, don't want to load duplicate data, only process changed data (CDC), think of it as the filtered up to date table, scd1 (replace data, no history)
third - historical, scd2

# Apache NiFi
Apache nifi is a web-based interface for designing and monitoring data flows. I chose NiFi over airflow because this project is simulating a continuous data flow and so deals with stream processing. The first screenshot below is the process group for this project.
![NIFI1](https://github.com/walker-at/Snowflake-DE-Project/assets/161479815/3ffc4314-c01e-4132-b798-a68f68133248)
The next screenshot goes within this process group, showing the 3 processors that fetch the newly generated file and reroute it to an aws s3 bucket, along with the 2 connections linking these processor nodes together.
![NIFI2](https://github.com/walker-at/Snowflake-DE-Project/assets/161479815/ff6e4102-4ad6-4aca-800e-2aad6dc900bf)

