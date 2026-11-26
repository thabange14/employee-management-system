USE ems;

CREATE OR REPLACE VIEW v_employee_details AS
SELECT
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS full_name,
    e.email,
    j.title                                AS job_title,
    d.name                                 AS department,
    CONCAT(m.first_name, ' ', m.last_name) AS manager,
    e.salary,
    e.hire_date,
    e.status
FROM employees e
JOIN jobs j         ON j.job_id = e.job_id
JOIN departments d  ON d.department_id = e.department_id
LEFT JOIN employees m ON m.employee_id = e.manager_id;