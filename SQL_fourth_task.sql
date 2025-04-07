WITH price_growth AS (
SELECT
	year AS price_year,
	round(((((avg(price_value) - LAG(avg(price_value)) OVER (ORDER BY year)) / LAG(avg(price_value)) OVER (ORDER BY year)) * 100)::NUMERIC), 2) AS percentage_price_increase
FROM t_jakub_taclik_project_SQL_primary_final
GROUP BY year
),
payroll_growth AS (
SELECT
	year AS payroll_year,
	round(((((avg(payroll_value) - LAG(avg(payroll_value)) OVER (ORDER BY year)) / LAG(avg(payroll_value)) OVER (ORDER BY year)) * 100)::NUMERIC), 2) AS percentage_payroll_increase
FROM t_jakub_taclik_project_SQL_primary_final
GROUP BY year
)
SELECT
	p.price_year,
	p.percentage_price_increase,
	pay.payroll_year,
	pay.percentage_payroll_increase,
	round(((p.percentage_price_increase - pay.percentage_payroll_increase)::NUMERIC), 2) AS difference
FROM price_growth p
JOIN payroll_growth pay
	ON p.price_year = pay.payroll_year	
WHERE (p.percentage_price_increase - pay.percentage_payroll_increase) > 10;
