# Snowflake-DE-Project


# Apache NiFi
Apache nifi is a web-based interface for designing and monitoring data flows. I chose NiFi over airflow because this project is simulating a continuous data flow and so deals with stream processing. The first screenshot below is the process group for this project.
![NIFI1](https://github.com/walker-at/Snowflake-DE-Project/assets/161479815/3ffc4314-c01e-4132-b798-a68f68133248)
The next screenshot goes within this process group, showing the 3 processors that fetch the newly generated file from aws s3 and reroute it to snowflake, along with the 2 connections linking the processor nodes together.
![NIFI2](https://github.com/walker-at/Snowflake-DE-Project/assets/161479815/ff6e4102-4ad6-4aca-800e-2aad6dc900bf)

