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

-- October 2026 payroll cost per department
SELECT
    d.name           AS department,
    COUNT(p.payroll_id) AS payslips,
    SUM(p.base_salary)  AS gross_pay,
    SUM(p.deductions)   AS total_deductions,
    SUM(p.net_pay)      AS total_net_pay
FROM departments d
LEFT JOIN employees e ON e.department_id = d.department_id
LEFT JOIN payroll p   ON p.employee_id = e.employee_id
                     AND p.pay_month = '2026-10-01'
GROUP BY d.department_id, d.name
ORDER BY total_net_pay DESC;

-- Attendance summary per employee
SELECT
    CONCAT(e.first_name, ' ', e.last_name) AS employee,
    COUNT(CASE WHEN a.status = 'PRESENT' THEN 1 END) AS present,
    COUNT(CASE WHEN a.status = 'LATE'    THEN 1 END) AS late,
    COUNT(CASE WHEN a.status = 'ABSENT'  THEN 1 END) AS absent,
    COUNT(CASE WHEN a.status = 'REMOTE'  THEN 1 END) AS remote
FROM employees e
LEFT JOIN attendance a ON a.employee_id = e.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name
ORDER BY e.employee_id;