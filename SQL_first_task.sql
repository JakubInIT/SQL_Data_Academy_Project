WITH payroll_changes AS (
    SELECT
        industry_name,
        avg(payroll_value) - LAG(avg(payroll_value)) OVER (PARTITION BY industry_name ORDER BY year) AS payroll_change
    FROM t_jakub_taclik_project_SQL_primary_final
    GROUP BY 
    	industry_name, 
    	year
),
industry_payroll AS (
    SELECT 
		industry_name,
        CASE 
            WHEN SUM(CASE WHEN payroll_change < 0 THEN 1 ELSE 0 END) > 0 
            THEN 'Payroll drop'
            ELSE 'Payroll growth'
        END AS payroll_information
    FROM payroll_changes
    GROUP BY
    	industry_name
)
SELECT  
	industry_name, 
	payroll_information
FROM industry_payroll
WHERE industry_name IS NOT NULL
GROUP BY  
	industry_name, 
	payroll_information;