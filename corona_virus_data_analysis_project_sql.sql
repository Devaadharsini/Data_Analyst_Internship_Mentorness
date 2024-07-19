use da_intern;

SELECT * FROM da_intern.corona_virus;

desc corona_virus;

alter table corona_virus modify Date Date;


-- Q1. Write a code to check NULL values---

 select * from corona_virus where Province is null or Country is null or Latitude is null or
 Longitude is null or Date is null or Confirmed is null or Deaths is null or Recovered is null ;

-- Q2. If NULL values are present, update them with zeros for all columns.--

update corona_virus set Province = 0,Country = 0,Latitude=0,Longitude=0, Date=0 ,Confirmed=0,
Deaths=0 , Recovered=0 where Province is null or Country is null or Latitude is null or
Longitude is null or Date is null or Confirmed is null or Deaths is null or Recovered is null ;

-- Q3. check total number of rows--

select count(*) as total_no_of_rows from corona_virus ;

-- Q4. Check what is start_date and end_date--

select MIN(Date) as Start_date , MAX(Date) as End_date from corona_virus;

-- Q5. Number of month present in dataset

select count(distinct month(Date)) as Number_of_months from corona_virus;

 -- Q6. Find monthly average for confirmed, deaths, recovered--
 
 select month(Date) as Month,year(Date) as Year ,
 round(avg(Confirmed),2) as Avg_of_Confirmed, 
 round(avg(Deaths),2) Avg_of_Deaths,round(avg(Recovered),2) as Avg_of_Recovered 
 from corona_virus group by Month ,Year;
 
 -- Q7. Find most frequent value for confirmed, deaths, recovered each month 

 with monthlystats as (
    select month(date) as month, year(Date) as Year, Confirmed, Deaths, Recovered,count(*) as frequency
    from corona_virus
    group by date, Year,Confirmed, Deaths, Recovered ),
rankedstats as (
    select month,Year, Confirmed, Deaths,
	Recovered,frequency, row_number() over (partition by month ,Year order by frequency desc) as ranks
    from monthlystats )
select month, Year, confirmed as most_frequent_confirmed, deaths as most_frequent_deaths,
recovered as most_frequent_recovered from rankedstats
where ranks = 1 order by month ,Year asc;

 
 -- Q8. Find minimum values for confirmed, deaths, recovered per year

select year(Date) as year, min(Confirmed) as Min_value_confirmed , 
min(Deaths)  as Min_value_deaths, min(Recovered)  as Min_value_recovered 
from corona_virus group by year;

-- Q9. Find maximum values of confirmed, deaths, recovered per year

select year(Date) as year , max(Confirmed) as Max_value_confirmed, 
max(Deaths) as Max_value_deaths, max(Recovered) as Max_value_recovered 
from corona_virus group by year;


 -- Q10. The total number of case of confirmed, deaths, recovered each month

select month(Date) as Month, year(Date) as Year,sum(Confirmed) as Number_of_confirmed,
sum(Deaths) as Number_of_Deaths,sum(Recovered) as Number_of_Recovered
from corona_virus group by Month,Year ;

 
 -- Q11. Check how corona virus spread out with respect to confirmed case

select Country , sum(Confirmed) as Total_confimed_cases,round(avg(Confirmed),2) as avg_of_confirmed, 
round(stddev_pop(Confirmed),2) as std_confirmed,
round(var_pop(Confirmed),2) var_confirmed from corona_virus group by Country ;

select Month(Date) as Month, sum(Confirmed) as Total_confimed_cases, round(avg(Confirmed),2) as avg_of_confirmed, 
round(stddev_pop(Confirmed),2) as std_confirmed,
round(var_pop(Confirmed),2) var_confirmed from corona_virus group by Month ;

select year(Date) as Year ,sum(Confirmed) as Total_confimed_cases,round(avg(Confirmed),2) as avg_of_confirmed, 
round(stddev_pop(Confirmed),2) as std_confirmed,
round(var_pop(Confirmed),2) var_confirmed from corona_virus group by Year;



-- Q12. Check how corona virus spread out with respect to death case per month

select Month(Date) as Month, year(Date) as Year,sum(Deaths) as Total_death_cases,
round(avg(Deaths),2) as avg_of_deaths, 
round(stddev_pop(Deaths),2) as std_deaths,
round(var_pop(Deaths),2) var_deaths from corona_virus group by Month ,Year;

-- Q13. Check how corona virus spread out with respect to recovered case

select Country, sum(Recovered) as Total_recovered_cases,round(avg(Recovered),2) as avg_of_recovered, 
round(stddev_pop(Recovered),2) as std_recovered,
round(var_pop(Recovered),2) var_recovered from corona_virus group by Country ;

select Month(Date) as Month , sum(Recovered) as Total_recovered_cases, 
round(avg(Recovered),2) as avg_of_recovered, 
round(stddev_pop(Recovered),2) as std_recovered,
round(var_pop(Recovered),2) var_recovered from corona_virus group by Month ;
 
select year(Date) as Year , sum(Recovered) as Total_recovered_cases,
round(avg(Recovered),2) as avg_of_recovered, 
round(stddev_pop(Recovered),2) as std_recovered,
round(var_pop(Recovered),2) var_recovered from corona_virus group by Year ; 
 
 -- Q14. Find Country having highest number of the Confirmed case

select Country,sum(Confirmed) as highest_confirmed_case from corona_virus group by Country 
order by highest_confirmed_case desc limit 1;

-- Q15. Find Country having lowest number of the death case


with info as ( select Country, sum(Deaths) as Lowest_cases , 
rank() over(order by sum(Deaths) asc ) as rank_order
from corona_virus group by Country)
select Lowest_cases,Country from info where rank_order=1;


 
 -- Q16. Find top 5 countries having highest recovered case
 
 select Country,sum(Recovered) as highest_recovered_case from corona_virus 
 group by Country order by highest_recovered_case desc limit 5 ;
 
 
 
 
 
select * from corona_virus;