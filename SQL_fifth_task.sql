WITH gdp_growth AS (
    SELECT 
        year, 
        avg(gdp) AS avg_gdp_in_actual_year,
        LAG(avg(gdp)) OVER (ORDER BY year) AS avg_gdp_in_previous_year
    FROM t_jakub_taclik_project_SQL_secondary_final
    GROUP BY YEAR    
),
payroll_growth AS (
    SELECT 
        year,
        avg(payroll_value) AS avg_payroll_in_actual_year,
        LAG(avg(payroll_value)) OVER (ORDER BY year) AS avg_payroll_in_previous_year
    FROM t_jakub_taclik_project_SQL_primary_final
    GROUP BY YEAR  
),
price_growth AS (
    SELECT 
        year, 
        avg(price_value) AS avg_price_in_actual_year,
        LAG(avg(price_value)) OVER (ORDER BY year) AS avg_price_in_previous_year
    FROM t_jakub_taclik_project_SQL_primary_final
    GROUP BY YEAR 
)
SELECT gdp.year,
      CASE
      	WHEN (avg_gdp_in_actual_year - avg_gdp_in_previous_year) > 0 THEN 'GDP growth'
      	ELSE 'GDP drop'
      END AS annual_gdp_progress,
      CASE
      	WHEN (avg_payroll_in_actual_year - avg_payroll_in_previous_year) > 0 THEN 'Payroll growth'
      	ELSE 'Payroll drop'
      END AS annual_payroll_progress,
      CASE
      	WHEN (avg_price_in_actual_year - avg_price_in_previous_year) > 0 THEN 'Price growth'
      	ELSE 'Price drop'
      END AS annual_price_progress
FROM gdp_growth gdp
LEFT JOIN payroll_growth pay ON gdp.year = pay.year
LEFT JOIN price_growth pri ON gdp.year = pri.YEAR
WHERE avg_gdp_in_actual_year IS NOT NULL
ORDER BY gdp.year;