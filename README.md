# Project from SQL

A project from the ENGETO Data Academy to obtain a certificate.
Discord name: JakubInIT.

## Assignment:
###Introduction to the project:
In your analytical department of an independent company focused on citizens' living standards, you have agreed to attempt to answer several defined research questions addressing the accessibility of basic foodstuffs to the general public. Your colleagues have already defined the core questions they will attempt to answer and provide this information to the press department. This department will present the results at an upcoming conference dedicated to this field.
They need you to prepare robust data resources where the comparison of food availability based on average incomes over a certain period can be observed.
As an additional material, prepare a table with GDP, the GINI coefficient, and the population of other European countries within the same period as the primary overview for the Czech Republic.

### Data sets that can be used to obtain suitable data resources:
#### Primary tables:
czechia_payroll – Information on wages in various sectors over several years. The dataset comes from the Czech Open Data Portal.
czechia_payroll_calculation – A reference table of calculations in the payroll table.
czechia_payroll_industry_branch – A reference table of industries in the payroll table.
czechia_payroll_unit – A reference table of value units in the payroll table.
czechia_payroll_value_type – A reference table of value types in the payroll table.
czechia_price – Information on the prices of selected foods over several years. The dataset comes from the Czech Open Data Portal.
czechia_price_category – A reference table of food categories appearing in our overview.
#### Reference tables of shared information about the Czech Republic:
czechia_region – A reference table of regions of the Czech Republic according to the CZ-NUTS 2 standard.
czechia_district – A reference table of districts of the Czech Republic according to the LAU standard.
#### Additional tables:
countries – Various information about countries worldwide, such as capital city, currency, national dish, or average population height.
economies – GDP, GINI, tax burden, etc., for a given country and year.

### Research questions:
1) Do wages increase across all sectors over the years, or do some decline?
2) How many liters of milk and kilograms of bread can be purchased in the first and last comparable periods in the available price and wage data?
3) Which category of food is becoming more expensive the slowest (has the lowest percentage year-over-year increase)?
4) Is there a year in which the year-over-year increase in food prices was significantly higher than the wage increase (more than 10%)?
5) Does GDP growth affect wage and food price changes? In other words, if GDP increases significantly in one year, does it reflect in food prices or wages increasing significantly in the same or the following year?

### Project outputs:
Help your colleagues with the given task. The output should be two tables in the database from which the required data can be obtained. Name the tables:
t_{first_name}_{last_name}_project_SQL_primary_final – For wage and food price data in the Czech Republic, unified to a comparable period (common years).
t_{first_name}_{last_name}_project_SQL_secondary_final – For additional data on other European countries.
Additionally, prepare a set of SQL queries to extract data from your tables to answer the defined research questions. Keep in mind that the questions/hypotheses can be supported or refuted by your outputs! It all depends on what the data says.
Create a public repository on your GitHub account where you store all project-related information—primarily the SQL script generating the final table, a description of intermediate results (a cover document), and information about output data (e.g., where values are missing, etc.).
Do not modify data in the primary tables! If transformation is needed, do so in newly created tables or views.

## Project structure:
-Table of food prices and wages by sector - t_jakub_taclik_project_SQL_primary_final
- Table with additional data on European countries - t_jakub_taclik_project_SQL_secondary_final
- SQL query for the first question - SQL_first_task
- SQL query for the second question - SQL_second_task
- SQL query for the third question - SQL_third_task
- SQL query for the fourth question - SQL_fourth_task
- SQL query for the fifth question - SQL_fifth_task

## Process:
### Creating a table of food prices and wages by sector:
First, I used LEFT JOIN to merge the table czechia_price via the column category_code with the table czechia_price_category via the column code, naming this merged table prices. By joining these two tables, I obtained mainly data about the food name, its code, and its prices over the given period.
Then, I used LEFT JOIN to merge the table czechia_payroll via the column industry_branch_code with the table czechia_payroll_industry_branch via the column code, naming this merged table payrolls. This provided me with data on industry names, codes, and wages over the given period. I also used WHERE to filter the value_type_code column with the value 5958.
Using SELECT, I extracted the columns category_name, price_value, industry_name, payroll_year, and year. I then merged the prices and payrolls tables using JOIN on the year column.

### Creating a table with additional data on other European countries:
I merged the economies and countries tables via the country column using JOIN.
Using SELECT, I extracted the columns country, continent, gdp, gini, population, and year.
With WHERE, I filtered only European countries and data for the period 2006-2018.

## SQL Queries:
### 1st Question:
I determined the average wage for each period and used LAG to get the previous year’s average wage.
Subtracting these values showed whether wages increased or decreased year-over-year.
Using CASE, I displayed "Payroll growth" when wages increased and "Payroll drop" when they decreased.

### 2nd Question:
I used MIN and MAX to find the first and last year of measurements.
With LIKE, I searched for data containing "milk" and "bread" and found their average prices in the first and last years.
Finally, I divided the average wage by the average price of milk and bread.

### 3rd Question:
To find the percentage year-over-year increase, I subtracted last year’s average price from this year’s, divided it by last year’s average, and multiplied by 100.
I grouped foods by name and rounded the increase to two decimal places.

### 4th Question:
I applied the percentage change formula to both wages and food prices, subtracted them, and checked if the result exceeded 10%.

### 5th Question:
I calculated the average GDP, food prices, and wages for the current and previous years.
Subtracting the previous year’s values from the current year’s, I checked whether they were positive or negative and used CASE to indicate growth or decline.

## Results:
### 1) Do wages increase across all sectors?
The data shows that wages in the sectors of Doprava a skladování, Ostatní činnosti, Zdravotní a sociální péče and Zpracovatelský průmysl increased year-on-year.
In other sectors such as Administrativní a podpůrné činnosti, Činnost v oblasti nemovitostí or Informační a komunikační činnosti, wages decreased in some years.

### 2) How much milk and bread could be purchased?
From the available data, it can be seen that:
In 2006, for an average wage of 20,754 CZK, I will buy an average of 1,437 liters of milk.
In 2006, for an average wage of 20,754 CZK, I will buy an average of 1,287 kilograms of bread.
In 2018, for an average wage of 32,536 CZK, I will buy an average of 1,642 liters of milk.
In 2018, for an average wage of 32,536 CZK, I will buy an average of 1,342 kilograms of bread.

### 3) Which food category increased the slowest?
From the available data, it can be seen that the slowest price increase is for Žluté banány, which have a year-on-year price increase of 0.81%.
The largest year-on-year increase is for Paprika, which have a 7.29% increase.
Cukr krystalový and Rajská jablka červená have even become cheaper.

### 4) Was food price growth ever 10% higher than wage growth?
No, from the available data it cannot be said that there was a year in which the year-on-year increase in food prices was 10% greater than the increase in wages.
The biggest difference was in 2013, when the year-on-year increase in food prices was 7.11% greater than the year-on-year increase in wages.

### 5) Does GDP influence wages and food prices?
There are periods when GDP and food prices and wages increased year-on-year in 2007 to 2008, 2011 to 2012 and 2017 to 2018.
But there are periods when the year-on-year increase or decrease in GDP had no effect on the year-on-year increase or decrease in food prices and wages.
For example, in 2009 and 2010 there was a decrease in GDP, but year-on-year wages did not decrease until 2013.
Conversely, from 2011 to 2018 GDP increased, but in 2015 and 2016 there was a decrease in food prices.
Therefore, there is no rule that an increase or decrease in GDP would have an impact on the increase or decrease in food prices and wages in the same or the following year.

