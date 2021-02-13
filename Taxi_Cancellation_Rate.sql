

-- TAXI CANCELLATION RATE

-- From the given trips and users tables for a taxi service, 
-- write a query to return the cancellation rate in the first two days in October, 
-- rounded to two decimal places, for trips not involving banned riders or drivers.

create database if not exists practicedb;
use practicedb;

create table if not exists users_trips (
user_id integer, 
banned varchar(20), 
type varchar(20));

create table if not exists trips (
trip_id integer, 
rider_id integer, 
driver_id integer, 
status varchar (40),
 request_date date);
/*
insert into trips (trip_id, rider_id, driver_id, status, request_date)
VALUES
(1, 1, 10, 'completed', CAST('2020-10-01' AS date)),
(2, 2, 11, 'cancelled_by_driver', CAST('2020-10-01' AS date)),
(3, 3, 12, 'completed', CAST('2020-10-01' AS date)),
(4, 4, 10, 'cancelled_by_rider', CAST('2020-10-02' AS date)),
(5, 1, 11, 'completed', CAST('2020-10-02' AS date)),
(6, 2, 12, 'completed', CAST('2020-10-02' AS date)),
(7, 3, 11, 'completed', CAST('2020-10-03' AS date));
insert into users_trips (user_id, banned, type)
VALUES
(1, 'no', 'rider'),
(2, 'yes', 'rider'),
(3, 'no', 'rider'),
(4, 'no', 'rider'),
(10, 'no', 'driver'),
(11, 'no', 'driver'),
(12, 'no', 'driver');
*/
select * from users_trips;
select * from trips;

select  request_date, round(1- sum( case when status = 'completed' then 1 else 0 end) / count(*),2) as cancellation_rate
from trips 
where rider_id not in (select user_id from users_trips where banned = 'yes')
and driver_id not in (select user_id from users_trips where banned = 'yes')
and request_date <= '2020-10-02'
group by request_date
having request_date <= '2020-10-02'
;
