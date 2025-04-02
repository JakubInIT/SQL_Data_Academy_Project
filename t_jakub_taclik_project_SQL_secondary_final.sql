CREATE TABLE t_jakub_taclik_project_SQL_secondary_final as
SELECT
	e.country AS country,
	c.continent AS continent,
	e.gdp AS gdp,
	e.gini AS gini,
	e.population AS population,
	e.YEAR AS year
FROM economies e
JOIN countries c
	ON c.country = e.country
WHERE (YEAR BETWEEN 2006 and 2018) AND continent = 'Europe'
ORDER BY country, YEAR;