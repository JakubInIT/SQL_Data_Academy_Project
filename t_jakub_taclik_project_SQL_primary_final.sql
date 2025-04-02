CREATE TABLE t_jakub_taclik_project_SQL_primary_final AS
WITH prices AS (
SELECT
	cpc.name AS category_name,
	cp.value AS price_value,
	date_part('year', cp.date_from) AS year
FROM czechia_price cp
LEFT JOIN czechia_price_category cpc
    ON cp.category_code = cpc.code
),
payrolls AS (
SELECT
	cpib.name AS industry_name,
	cpay.value AS payroll_value,
	cpay.payroll_year AS year2
FROM czechia_payroll cpay
LEFT JOIN czechia_payroll_industry_branch cpib
	ON cpay.industry_branch_code = cpib.code
WHERE value_type_code = 5958 AND industry_branch_code IS NOT NULL
)
SELECT
	category_name,
	price_value,
	industry_name,
	payroll_value,
	year
FROM prices pri
JOIN payrolls pay
	ON pri.YEAR = pay.year2;