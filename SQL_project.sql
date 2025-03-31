SELECT
count(1)
FROM czechia_price cp
JOIN czechia_price_category cpc
ON cp.category_code = cpc.code
WHERE cpc.name LIKE '%Chléb%'

SELECT
count(1)
FROM czechia_price cp
JOIN czechia_price_category cpc
ON cp.category_code = cpc.code
WHERE cp.category_code = '114201'

SELECT
count(1)
FROM czechia_price cp
JOIN czechia_price_category cpc
ON cp.category_code = cpc.code
WHERE cpc.name LIKE '%Mléko%'

SELECT
count(1)
FROM czechia_price cp
JOIN czechia_price_category cpc
ON cp.category_code = cpc.code
WHERE cp.category_code = '111301'

--------------------------------

SELECT
count(1)
FROM czechia_price_category cpc
WHERE cpc.name LIKE '%Chléb%'

SELECT
count(1)
FROM czechia_price cp
WHERE cp.category_code = '114201'

SELECT
count(1)
FROM czechia_price_category cpc
WHERE cpc.name LIKE '%Mléko%'

SELECT
count(1)
FROM czechia_price cp
WHERE cp.category_code = '111301'

SELECT *
FROM czechia_payroll cp
JOIN czechia_payroll_industry_branch cpib 
	ON cp.industry_branch_code = cpib.code 
WHERE cp.value_type_code != 316

SELECT
	cp.category_code,
	cpc.name
FROM czechia_price cp 
JOIN czechia_price_category cpc 
	ON cp.category_code = cpc.code

	
	
WITH value_growth AS (
SELECT 
	food_name,
	year,
	avg(price_value) AS average_price,
	LAG(avg(price_value)) OVER (PARTITION BY food_name ORDER BY year),
	((avg(price_value) - LAG(avg(price_value)) OVER (PARTITION BY food_name ORDER BY year))/LAG(avg(price_value)) OVER (PARTITION BY food_name ORDER BY year))*100 AS percent_price_growth
FROM t_jakub_taclik_sql_primal_final
GROUP BY food_name, year
)
SELECT
	food_name,
	round((avg(percent_price_growth)::NUMERIC),2) AS average_annual_growth
FROM value_growth
GROUP BY food_name
ORDER BY avg(percent_price_growth)


SELECT *
FROM czechia_payroll

SELECT *
FROM czechia_price


	SELECT
		year,
		avg(payroll_value) AS average_payroll,
		avg(payroll_value) / avg(CASE WHEN lower(food_name) LIKE '%mléko%' THEN price_value END),
		avg(payroll_value) / avg(CASE WHEN lower(food_name) LIKE '%chléb%' THEN price_value END),
		avg(CASE WHEN lower(food_name) LIKE '%mléko%' THEN price_value END) AS milk_price,
		avg(CASE WHEN lower(food_name) LIKE '%chléb%' THEN price_value END) AS bread_price
	FROM t_jakub_taclik_sql_primal_final
    GROUP BY 
    	YEAR
    	
    	
  	SELECT
		year,
		avg(payroll_value) AS average_payroll,
		avg(payroll_value) / avg(CASE WHEN category_code = '114201' THEN price_value END),
		avg(payroll_value) / avg(CASE WHEN category_code = '111301' THEN price_value END),
		avg(CASE WHEN category_code = '114201' THEN price_value END) AS milk_price,
		avg(CASE WHEN category_code = '111301' THEN price_value END) AS bread_price
	FROM t_jakub_taclik_sql_primal_test
    GROUP BY 
    	YEAR
   

----------------------------------------------------------------------------------------------    	

SELECT
	c.continent,
	avg(e.gdp) AS average_gdp,
	e.year
FROM economies e
JOIN countries c
	ON c.country = e.country
WHERE (YEAR BETWEEN 2006 and 2018) AND continent = 'Europe'
GROUP BY c.continent, e.YEAR
ORDER BY e.YEAR

SELECT *
FROM t_jakub_taclik_project_SQL_secondary_final sec
JOIN t_jakub_taclik_project_SQL_primary_final prim
	ON sec.YEAR = prim.year

SELECT
	avg(s.gdp) AS average_gdp,
	s.YEAR,
	avg(p.price_value) AS average_price_value,
	avg(p.payroll_value) AS average_payroll_value,
	p.year
FROM t_jakub_taclik_project_SQL_secondary_final s
JOIN t_jakub_taclik_project_SQL_primary_final p
	ON s.YEAR = p.YEAR
GROUP BY s.YEAR, p.YEAR
ORDER BY s.YEAR


CREATE OR REPLACE VIEW v_libor_zizala_project_SQL_primary_final AS -- nejrpve vytvořeno VIEW pro snazší odladění 
SELECT 
	cpc.name AS food_category, 
    cpc.price_value AS price_volume,
    cpc.price_unit AS price_unit,	
	AVG(cp.value) AS avg_price,
    date_part('year',cp.date_from) AS year_id,
    NULL AS industry,
    NULL AS avg_wages    
FROM czechia_price cp 
JOIN czechia_price_category cpc
    ON cp.category_code = cpc.code
WHERE date_part('year',cp.date_from) IN 
	(SELECT DISTINCT
    	payroll_year 
    	FROM czechia_payroll	
    	)
GROUP BY food_category, year_id 
UNION  
SELECT 
	NULL AS food_category,
	NULL AS price_volume,
	NULL AS price_unit,
	NULL AS avg_price,
	cpay.payroll_year AS year_id,
	cpib.name AS industry,
    AVG(cpay.value) AS avg_wages    
FROM czechia_payroll cpay
JOIN czechia_payroll_industry_branch AS cpib
    ON cpay.industry_branch_code = cpib.code 
WHERE 
	cpay.value_type_code = 5958 AND 
    cpay.calculation_code = 100 AND 
    cpay.payroll_year IN
    	(SELECT DISTINCT
    		YEAR(date_from) 
    	FROM czechia_price	
    	)
GROUP BY industry, year_id ;


SELECT *
FROM czechia_price
ORDER BY 