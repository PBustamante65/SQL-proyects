-- We create a new database to begin working
CREATE DATABASE SupplyChain;

-- We review our data
SELECT * FROM supply;

-- We start doing simple analysis, by checking the amount of products sold by type
SELECT `Product type`, SUM(`Number of products sold`) AS Total_Sold
FROM supply
GROUP BY `Product type`;

-- Then we check the total revenue by type
SELECT `Product type`, SUM(`Revenue generated`) AS Total_Revenue
FROM supply
GROUP BY `Product type`;

-- We want to find a relation between price and revenue on a scatter plot, depending on the type of product
SELECT `Product type`, Price, `Revenue generated`
FROM supply;

-- We check which carrier brings in the most revenue
SELECT `Shipping carriers`, SUM(`Revenue generated`) AS Total_Revenue
FROM supply
GROUP BY `Shipping carriers`;

-- We analyse avg shipping costs and times per carrier
SELECT `Shipping carriers`, AVG(`Shipping costs`) AS "Average Cost", AVG(`Shipping times`) AS "Average Time"
FROM supply
GROUP BY `Shipping carriers`;

-- We want to identify the supliers with the shortest time and manufacturing costs
SELECT `Supplier name`, MIN(`Manufacturing lead time`) AS "Shortest lead time", MIN(`Manufacturing costs`) "Cheapest cost"
FROM supply
GROUP BY `Supplier name`;

-- We compare each transportation mode by each carrier
SELECT `Shipping carriers`, `Transportation modes`, AVG(`Shipping costs`) AS "Average shipping cost"
FROM supply
GROUP BY `Shipping carriers`, `Transportation modes`;

-- We can analyse which demographic generates more revenue
SELECT `Customer demographics`,AVG(`Revenue generated`) AS "Average Revenue"
FROM supply
GROUP BY `Customer demographics`;

-- We calculate the average defect by product
SELECT `Product type`, AVG(`Defect rates`)
FROM supply
GROUP BY `Product type`;