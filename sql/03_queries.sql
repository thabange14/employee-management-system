USE ems;

-- All employees with their job, department and manager
SELECT
    CONCAT(e.first_name, ' ', e.last_name) AS employee,
    j.title                                AS job,
    d.name                                 AS department,
    CONCAT(m.first_name, ' ', m.last_name) AS manager,
    e.salary
FROM employees e
JOIN jobs j         ON j.job_id = e.job_id
JOIN departments d  ON d.department_id = e.department_id
LEFT JOIN employees m ON m.employee_id = e.manager_id
ORDER BY d.name, e.last_name;

-- Headcount and salary figures per department
SELECT
    d.name                  AS department,
    COUNT(e.employee_id)    AS headcount,
    ROUND(AVG(e.salary), 2) AS avg_salary,
    SUM(e.salary)           AS total_salary_cost
FROM departments d
LEFT JOIN employees e ON e.department_id = d.department_id
GROUP BY d.department_id, d.name
ORDER BY headcount DESC;


-- Pending leave requests with employee names and number of days
SELECT
    l.leave_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee,
    l.leave_type,
    l.start_date,
    l.end_date,
    DATEDIFF(l.end_date, l.start_date) + 1 AS days,
    l.reason
FROM leave_requests l
JOIN employees e ON e.employee_id = l.employee_id
WHERE l.status = 'PENDING';