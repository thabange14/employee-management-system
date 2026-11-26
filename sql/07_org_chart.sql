USE ems;

WITH RECURSIVE org AS (
    -- Start with people who have no manager
    SELECT employee_id,
           CONCAT(first_name, ' ', last_name) AS name,
           0 AS level,
           CAST(CONCAT(first_name, ' ', last_name) AS CHAR(500)) AS path
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    -- Then repeatedly add the people who report to someone already found
    SELECT e.employee_id,
           CONCAT(e.first_name, ' ', e.last_name),
           o.level + 1,
           CONCAT(o.path, '/', e.first_name, ' ', e.last_name)
    FROM employees e
    JOIN org o ON e.manager_id = o.employee_id
)
SELECT CONCAT(REPEAT('    ', level), name) AS org_chart
FROM org
ORDER BY path;