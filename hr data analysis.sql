CREATE DATABASE hr_analysis;

use hr_analysis;

show tables;
-- What is the total number of employees in the organization?
select count(*) as total_employees
from hr_analytics_cleaned;

-- How many employees have exited the organization?
select count(*) as employees_left
from hr_analytics_cleaned
where Attrition = 'Yes';

-- What percentage of the workforce has experienced attrition?
select 
round(sum(case when Attrition = 'Yes' then 1 else 0 end) * 100.0/ count(*), 2) as attrition_rate
from hr_analytics_cleaned;

-- How is the workforce distributed across different departments?
select Department,
COUNT(*) as employee_count
from hr_analytics_cleaned
group by Department
order by employee_count desc;

-- Which job roles have the highest employee attrition?
select JobRole,
count(*) as employees_left
from hr_analytics_cleaned
where Attrition = 'Yes'
group by JobRole
order by employees_left desc;

-- Does employee tenure differ between employees who stayed and those who left?
select Attrition,
round(avg(YearsAtCompany), 2)as average_years_at_company
from hr_analytics_cleaned
group by Attrition;

-- Is monthly income associated with employee attrition?
select Attrition,
round(avg(MonthlyIncome), 2) as average_monthly_income
from hr_analytics_cleaned
group by Attrition;

-- What is the average age of employees in each department?
select Department,
ROUND(avg(Age), 2) as average_age
from hr_analytics_cleaned
group by Department
order by average_age desc;

-- Which department has the highest number of employees aged above 50?
select Department,
count(*) as employees_above_50
from hr_analytics_cleaned
where Age > 50
group by Department
order by employees_above_50 desc;

-- Which job roles have employees who have spent the longest time in their current role?
select JobRole,
round(avg(YearsInCurrentRole), 2) as avg_years_current_role
from hr_analytics_cleaned
group by JobRole
order by avg_years_current_role desc;

-- How many employees have more than 20 years of total work experience?
select COUNT(*) as experienced_employees
from hr_analytics_cleaned
where TotalWorkingYears > 20;

-- What is the average number of companies previously worked for by employees in each department?
select Department,
ROUND(avg(NumCompaniesWorked), 2) as avg_previous_companies
FROM hr_analytics_cleaned
group by Department
order by avg_previous_companies desc;

-- What is the average education level across departments?
select Department,
ROUND(avg(Education), 2) as average_education_level
from hr_analytics_cleaned
group by Department
order by average_education_level desc;

-- Which job roles have the highest average performance rating?
select JobRole,
ROUND(avg(PerformanceRating), 2) as avg_performance_rating
FROM hr_analytics_cleaned
group by JobRole
order by avg_performance_rating desc;

-- What is the average number of training sessions received by employees at each job level?
select JobLevel,
ROUND(avg(TrainingTimesLastYear), 2) as avg_training_sessions
from hr_analytics_cleaned
group by JobLevel
order by JobLevel;

-- Which employees have received no training in the last year?
select EmployeeID,Department,JobRole,TrainingTimesLastYear
from hr_analytics_cleaned
where TrainingTimesLastYear = 0
order by Department, JobRole;

-- Which employees travel frequently for business and have low job satisfaction?
select EmployeeID,Department,JobRole,BusinessTravel,JobSatisfaction
from hr_analytics_cleaned
where BusinessTravel = 'Travel_Frequently'
and JobSatisfaction <= 2
order by JobSatisfaction, Department;

-- Which marital-status group has the highest average monthly income?
select MaritalStatus,
COUNT(*) AS employee_count,ROUND(avg(MonthlyIncome), 2) as average_income
from hr_analytics_cleaned
group by MaritalStatus
order by average_income desc;

-- Which employees have changed roles less frequently than expected for their tenure?
select EmployeeID,Department,JobRole,YearsAtCompany,YearsInCurrentRole
from hr_analytics_cleaned
where YearsAtCompany >= 5 and YearsInCurrentRole >= 4
order by YearsInCurrentRole desc;

-- Which employees have worked in more companies than the average employee?
select EmployeeID,Department,JobRole,NumCompaniesWorked
from hr_analytics_cleaned
where NumCompaniesWorked > (select avg(NumCompaniesWorked)
    from hr_analytics_cleaned
)
order by NumCompaniesWorked desc;

-- Which employees have not received a promotion despite having at least 10 years at the company?
select EmployeeID,Department,JobRole,YearsAtCompany,YearsSinceLastPromotion
from hr_analytics_cleaned
where YearsAtCompany >= 10 and YearsSinceLastPromotion >= 5
order by YearsSinceLastPromotion desc;

-- Which education levels have the highest average monthly income?
select Education,
COUNT(*) as employee_count,ROUND(avg(MonthlyIncome), 2) as avg_monthly_income
from hr_analytics_cleaned
group by Education
order by avg_monthly_income desc;


































