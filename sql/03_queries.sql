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