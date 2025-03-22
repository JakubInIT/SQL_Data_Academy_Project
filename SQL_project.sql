/* První výzkumná otázka:
Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
*/
 
SELECT 
	cp.industry_branch_code,
	cpib.name,
	avg(cp.value) AS avg_value,
	cp.payroll_year
FROM
	czechia_payroll cp
LEFT JOIN czechia_payroll_industry_branch cpib 
	ON
	cp.industry_branch_code = cpib.code
WHERE
	value_type_code = '5958'
GROUP BY
	cp.industry_branch_code,
	cpib.name,
	cp.payroll_year
ORDER BY
	industry_branch_code,
	avg_value;

/* V některých odvětvích mzdy klesají. 
 * Např. odvětví A - Zemědělství, lesnictví, rybářství, kdy po roce 2008 mzda klesla.
 * 
 * V některých odvětvích mzdy rostou.
 * Např. odvětví C - Zpracovatelský průmysl, kdy mzda každý rokem rostla.
*/
