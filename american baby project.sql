show databases; 
use new_schema;
describe baby_names;
select * from baby_names;


/*Select first names and the total babies with that first_name
-- Group by first_name and filter for those names that appear in all 101 years
-- Order by the total number of babies with that first_name, descending*/
SELECT name, sum(Count)
from baby_names
group by name
having count(year) = 70
order by sum(count) desc;

/*-- Classify names as 'Classic', 'Semi-classic', 'Semi-trendy', or 'Trendy'
-- Alias this column as popularity_type
-- Select name, the sum of babies who have ever had that name, and popularity_type
-- Order the results alphabetically by name*/

select name,year,sum(count),count(year),
	case
		when count(year)>60 then 'Classic'
        when count(year)>50 then 'semi-classic'
        when count(year)>20 then 'Semi trendy'
        else 'trendy'
        end as popularity_type
from baby_names
group by name
order by count(year);
    
    
    /*-- RANK names by the sum of babies who have ever had that name (descending), aliasing as name_rank
-- Select name_rank, first_name, and the sum of babies who have ever had that name
-- Filter the data for results where sex equals 'F'
-- Limit to ten results*/

select rank() over(order by sum(count) desc)as name_rank, name, sum(count) from baby_names where Gender ='F'
group by name
limit 10;

/*Select only the name column
Filter for results where sex is 'F', year is greater than 2015, and first_name ends in 'a'
Group by first_name and order by the total number of babies given that first_name*/

select name,year,sum(count) from baby_names  where Gender='F'and name like '%a' group by name order by sum(count) desc;

/*Select year, first_name, num of anna in that year, and cumulative_anna
-- Sum the cumulative babies who have been named anna up to that year; alias as cumulative_olivias
-- Filter so that only data for the name anna is returned.
-- Order by year from the earliest year to most recent*/

select year,name,sum(count) over(order by year)  as cumulative_anna from baby_names where name='anna' order by year desc;

/*-- Select year and maximum number of babies given any one male name in that year, aliased as max_num
-- Filter the data to include only results where sex equals 'M'*/

select year,max(count) as max_number from baby_names where gender='M' group by year;

/* Select year, name given to the largest number of male babies, and num of babies given that name
-- Join baby_names to the code in the last task as a subquery
-- Order results by year descending*/

select b.year,b.name,b.count from baby_names as b
inner join
(
select year,max(count) as max_number from baby_names where gender='M' group by year
)as subquery 
on 
subquery.year=b.year
and
subquery.max_number=b.count
order by year desc;

/*the longest name starting with letter L and ending with a*/
SELECT name,MAX(LENGTH(name))Length,year,count FROM baby_names WHERE name LIKE 'L%a';
