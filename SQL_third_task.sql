WITH price_growth AS (
SELECT 
	category_name,
	year,
	(((avg(price_value) - LAG(avg(price_value)) OVER (PARTITION BY category_name ORDER BY year))/LAG(avg(price_value)) OVER (PARTITION BY category_name ORDER BY year))*100) AS percent_price_growth
FROM t_jakub_taclik_project_SQL_primary_final
GROUP BY category_name, year
)
SELECT
	category_name,
	round((avg(percent_price_growth)::NUMERIC), 2) AS average_annual_growth
FROM price_growth
WHERE category_name IS NOT NULL
GROUP BY category_name
ORDER BY avg(percent_price_growth);
