
-- We set Safe Update off so its possible to update multiple rows at the same time, this will come in handy later
SET SQL_SAFE_UPDATES = 0;

-- First, we take a look at our database, at first inspection, it looks like the DB dosnt have any NULL values to fix, so we can continue working
SELECT * FROM accidents;

-- We change AccidentCount from the table to avoid issues
ALTER TABLE accidents
RENAME COLUMN AccidentCount TO AccidentCount;

-- First thing we want to know, is, how many accidents are there per city, so we run the next code, that sums the AccidentCount column but only when the outcome of 
-- the incident is 'Total number of accidents', since theres different subcategories, each with its own 'total number of accidents' row
-- Then we group each of this sums by city
SELECT DISTINCT `Million Plus Cities`,SUM(AccidentCount) AS "Total Accidents"
FROM accidents
WHERE`Outcome of Incident` = "Total number of Accidents"
GROUP BY `Million Plus Cities`
ORDER BY SUM(AccidentCount) DESC;

-- Next we are gonna add a new column, name population, so we can do some further analisis
ALTER TABLE accidents
ADD population INT
FIRST;

SELECT * FROM accidents;

-- We set the value of population per each city				
UPDATE accidents
SET population = 2358412 
WHERE `Million Plus Cities` = "Vizaq";

-- For further manipulation, its better if we create a new table which contains only the population
CREATE TABLE population (

	population INT,
    `Million Plus Cities` VARCHAR(50)

);

-- We migrate the data from one table to another
INSERT INTO population (population, City)
SELECT population, `Million Plus Cities` 
FROM accidents;


SELECT * FROM population;

-- And now we drop the old column from the accidents table
ALTER TABLE accidents
DROP population;

-- We want to create a query that shows us the city, the number of accidents, and the population of each.
-- To accomplish this, we must join 2 tables, theres where the new population table comes in play.
-- So we select the cities and the accidents from the accidents table, and the population from the population table, then we add a fourth column named accident_percentage
-- that tells us the accidents per capita for each city.
-- We select all this data from a subquery thats basically the same as the first one we made, and then we join it with the population table.
-- Finally we order everything by accidents per capita.
SELECT a.`Million Plus Cities`, a.total_accidents, b.population, ROUND((a.total_accidents / b.population) * 100,3) AS accident_per_capita
FROM (
	SELECT `Million Plus Cities`, SUM(AccidentCount) AS total_accidents
    FROM accidents
    WHERE `Outcome of Incident` = "Total number of Accidents"
    GROUP BY `Million Plus Cities`
	
) a
JOIN population b
ON a.`Million Plus Cities`= b.`Million Plus Cities`
GROUP BY `Million Plus Cities`, population
ORDER BY accident_per_capita DESC;

----------------------------
-- We proceed to do a further analysis to Jabalpur the second most city with accidents per capita
-- We are gonna inspect by category
SELECT `Million Plus Cities`,`Cause category`,`Outcome of Incident`, AccidentCount
FROM accidents
WHERE `Million Plus Cities` = "Kollam" AND `Outcome of Incident` = "Total number of Accidents"
GROUP BY `Million Plus Cities`, `Cause category`, `Outcome of Incident`, AccidentCount;

SELECT *
FROM accidents
WHERE `Million Plus Cities` = "Kollam" AND `Outcome of Incident` = "Total number of Accidents" ;

SELECT `Million Plus Cities`, `Cause category`, `Outcome of Incident`, SUM(AccidentCount) AS TotalCount
FROM accidents
WHERE `Million Plus Cities` = "Kollam" AND `Outcome of Incident` = "Total number of Accidents"
GROUP BY `Million Plus Cities`, `Cause category`;
