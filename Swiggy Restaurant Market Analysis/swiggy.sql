-- Customer Behavior & Preferences --
SET SQL_SAFE_UPDATES = 0;

-- Which food type has the highest average rating across all cities? --
select `Food type` , `Avg ratings`
from swiggy.swiggy
where `Avg ratings` in (select max(`Avg ratings`) from swiggy.swiggy);

-- Is there a significant difference in average ratings between vegetarian and non-vegetarian food types? --
--- ** unless adding another column you must use group by in the same query ----
ALTER TABLE swiggy.swiggy ADD COLUMN cleaned_food_type VARCHAR (400);

UPDATE swiggy.swiggy
SET cleaned_food_type = TRIM(LOWER(`Food type`));

SELECT Food_Category, ROUND(AVG(`Avg ratings`), 2) AS avg_rating
from (
SELECT *,
  CASE 
    WHEN cleaned_food_type LIKE '%biryani%' OR cleaned_food_type LIKE '%mughlai%' OR cleaned_food_type LIKE '%seafood%' THEN 'Non-Vegetarian'
    WHEN cleaned_food_type LIKE '%jain%' OR cleaned_food_type LIKE '%pure veg%' OR cleaned_food_type LIKE '%south indian%' THEN 'Vegetarian'
    WHEN cleaned_food_type LIKE '%north indian%' OR cleaned_food_type LIKE '%chinese%' OR cleaned_food_type LIKE '%fast food%' OR cleaned_food_type LIKE '%continental%' THEN 'Mixed'
    ELSE 'Unknown'
  END AS Food_Category
FROM swiggy.swiggy
) as categorized 
group by Food_Category;

-- Which cities prefer premium-priced restaurants over budget ones (based on average price per order)? --
select avg(Price) from swiggy.swiggy;

SELECT 
  City,
  ROUND(AVG(Price), 2) AS avg_price_per_order,
  CASE 
    WHEN AVG(Price) >= 400 THEN 'Premium Preference'
    WHEN AVG(Price) BETWEEN 200 AND 399 THEN 'Mid-range Preference'
    ELSE 'Budget Preference'
  END AS Price_Category
FROM swiggy.swiggy
GROUP BY City
ORDER BY avg_price_per_order DESC;

-- Does a higher price correlate with higher average ratings across restaurants? --
SELECT
  (AVG(Price * `Avg ratings`) - AVG(Price) * AVG(`Avg ratings`)) /
  (STDDEV(Price) * STDDEV(`Avg ratings`)) AS correlation
FROM swiggy.swiggy;

-- How does delivery time affect customer ratings in different areas? --
SELECT 
  Area,
  ROUND(AVG(`Delivery time`), 2) AS avg_delivery_time,
  ROUND(AVG(`Avg ratings`), 2) AS avg_rating,
  (AVG(`Delivery time` * `Avg ratings`) - AVG(`Delivery time`) * AVG(`Avg ratings`)) /
  (STDDEV(`Delivery time`) * STDDEV(`Avg ratings`)) AS correlation
FROM swiggy.swiggy
GROUP BY Area
ORDER BY correlation;

---  Without Null Value ---
SELECT 
  Area,
  ROUND(AVG(`Delivery time`), 2) AS avg_delivery_time,
  ROUND(AVG(`Avg ratings`), 2) AS avg_rating,
  (AVG(`Delivery time` * `Avg ratings`) - AVG(`Delivery time`) * AVG(`Avg ratings`)) /
  (STDDEV(`Delivery time`) * STDDEV(`Avg ratings`)) AS correlation
FROM swiggy.swiggy
WHERE `Delivery time` IS NOT NULL AND `Avg ratings` IS NOT NULL
GROUP BY Area
HAVING COUNT(*) > 2;

-- Which area within each city has the highest-rated restaurants on average? --

