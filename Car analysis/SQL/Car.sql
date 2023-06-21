-- Before anything, we create a new DB to work our data
-- Once created, we import a CSV file containing all the data and create a new table with it
CREATE DATABASE Cars;

-- We review our data
SELECT * FROM automobile;c 

-- We run a query to exclude and count the amount of times a brand is mentioned
SELECT SUBSTRING_INDEX(name, ' ', 1) AS Brands, COUNT(*) AS brand_count
FROM automobile
GROUP BY Brands
ORDER BY brand_count DESC;

-- Once we ran the previous query, we realize theres several typos, so before we continue working, we must fix them
-- First, we add an id column so it can be easier to find and update the rows with typos
ALTER TABLE automobile
ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY FIRST;

-- So now, we set out to find the typos and fix them
UPDATE automobile
SET name = "toyota corona mark ii(sw)"
WHERE id = 311;

SELECT * FROM automobile
WHERE name LIKE "toyouta%";

-- We also add the country of origin
SELECT SUBSTRING_INDEX(name, ' ', 1) AS Brands, COUNT(*) AS brand_count, origin
FROM automobile
GROUP BY Brands, origin
ORDER BY brand_count DESC;

-- Now we will investigate how many mpg do most cars do
SELECT mpg, count(*) AS "Count"
FROM automobile
GROUP BY mpg;

-- We will calculate de average mpg by brand
SELECT SUBSTRING_INDEX(name, ' ', 1) AS Brands, AVG(mpg) AS "Average MPG"
FROM automobile
GROUP BY Brands
ORDER BY AVG(mpg) DESC;

-- Now we are gonna calculate the average mpg per origin
SELECT origin, AVG(mpg) AS "Average MPG"
FROM automobile
GROUP BY origin;

-- We can analyse the MPG consumed by model year
SELECT model_year, AVG(mpg) AS "Average MPG"
FROM automobile
GROUP BY model_year
ORDER BY model_year;

-- We can also check which were the most common cylinders used 
SELECT cylinders, COUNT(*) AS count
FROM automobile
GROUP BY cylinders
ORDER BY count DESC;

-- We can do a horsepower distribution by model year
SELECT model_year, MIN(horsepower) AS "Minimum hp", MAX(horsepower) AS "Maximum hp", AVG(horsepower) AS "Average hp"
FROM automobile
GROUP BY model_year
ORDER BY model_year;

-- We can search the top 10 fastest cars
SELECT name, model_year, acceleration 
FROM automobile
ORDER BY acceleration
LIMIT 10;

-- We do a weight to power ratio
SELECT name, model_year, weight / horsepower AS weight_power_ratio
FROM automobile
ORDER BY weight_power_ratio ASC;



