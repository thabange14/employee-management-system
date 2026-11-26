USE ems;

DELIMITER //

CREATE TRIGGER trg_salary_audit
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    IF OLD.salary <> NEW.salary THEN
        INSERT INTO salary_audit (employee_id, old_salary, new_salary)
        VALUES (OLD.employee_id, OLD.salary, NEW.salary);
    END IF;
END//

DELIMITER ;

DELIMITER //

CREATE TRIGGER trg_validate_salary_range
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    DECLARE lo DECIMAL(12,2);
    DECLARE hi DECIMAL(12,2);

    SELECT min_salary, max_salary INTO lo, hi
    FROM jobs
    WHERE job_id = NEW.job_id;

    IF NEW.salary < lo OR NEW.salary > hi THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary is outside the allowed range for this job';
    END IF;
END//

DELIMITER ;