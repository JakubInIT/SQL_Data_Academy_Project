WITH years AS (
	SELECT 
		MIN(year) AS first_year,
		MAX(year) AS last_year
	FROM t_jakub_taclik_project_SQL_primary_final	
),
payrolls AS (
	SELECT
		year,
		avg(payroll_value) AS average_payroll,
		avg(CASE WHEN lower(category_name) LIKE '%mléko%' THEN price_value END) AS milk_price,
		avg(CASE WHEN lower(category_name) LIKE '%chléb%' THEN price_value END) AS bread_price
	FROM t_jakub_taclik_project_SQL_primary_final
	WHERE YEAR IN (SELECT first_year FROM years) OR YEAR IN (SELECT last_year FROM years)
    GROUP BY 
    	YEAR
)
SELECT
	YEAR,
	round((average_payroll::NUMERIC),0) AS average_payroll_in_Kc,
	round(((average_payroll / milk_price)::NUMERIC),0) AS amout_of_milk_in_liters,
	round(((average_payroll / bread_price)::NUMERIC),0) AS amout_of_bread_in_kilograms
FROM payrolls
ORDER BY YEAR;