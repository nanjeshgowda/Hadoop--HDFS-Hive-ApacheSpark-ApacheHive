----------------------------------------
1. Sensor Data Loaded into Oracle Cloud.
----------------------------------------
wget -O baseball_salaries_2003.txt https://s3.amazonaws.com/hipicdatasets/baseball_salaries_2003.txt

------------------
2. Create folders.
------------------

hdfs dfs -mkdir baseball_salaries

hdfs dfs -chmod -R o+w baseball_salaries

hdfs dfs -put baseball_salaries_2003.txt baseball_salaries

hdfs dfs -ls baseball_salaries

-------------------------
3. Connecting to beeline.
-------------------------
beeline

!connect jdbc:hive2://cis5200-bdcsce-4.compute-608214094.oraclecloud.internal:2181,cis5200-bdcsce-2.compute-608214094.oraclecloud.internal:2181,cis5200-bdcsce-3.compute-608214094.oraclecloud.internal:2181/;serviceDiscoveryMode=zooKeeper;zooKeeperNamespace=hiveserver2?tez.queue.name=interactive bdcsce_admin

-----------------------------------
4. Creating table baseball_salaries
-----------------------------------
SHOW DATABASES;
USE amahesh3;

DROP TABLE IF EXISTS baseball_salaries;

CREATE EXTERNAL TABLE IF NOT EXISTS baseball_salaries(b_Team STRING, b_Player STRING, b_Salary double, b_Position STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY ':' STORED AS TEXTFILE LOCATION '/user/amahesh3/baseball_salaries';

----------------------------
5. Query 10 data from table.
----------------------------

select * from baseball_salaries LIMIT 10;

----------------------------------------
6. Top 5 data ordered by highest salary.
----------------------------------------

select * from baseball_salaries ORDER BY b_salary DESC LIMIT 5;

---------------------------------------------------------------
7. Lowest 5 data ordered by salary of position " First Baseman"
---------------------------------------------------------------

select * from baseball_salaries where b_position like "% First Baseman%" ORDER BY b_salary ASC LIMIT 5;

------------------
8. Average Salary.
------------------

select b_position, AVG(b_salary) as AverageSalary from baseball_salaries GROUP BY b_position;

