USE ems;

DELIMITER //

CREATE PROCEDURE sp_give_raise(IN p_employee INT, IN p_percent DECIMAL(5,2))
BEGIN
    UPDATE employees
    SET salary = ROUND(salary * (1 + p_percent / 100), 2)
    WHERE employee_id = p_employee
      AND status = 'ACTIVE';
END//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_generate_payroll(IN p_month DATE)
BEGIN
    INSERT IGNORE INTO payroll (employee_id, pay_month, base_salary, bonus, deductions)
    SELECT employee_id,
           DATE_FORMAT(p_month, '%Y-%m-01'),
           salary,
           0,
           ROUND(salary * 0.15, 2)
    FROM employees
    WHERE status = 'ACTIVE';
END//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_terminate_employee(IN p_employee INT)
BEGIN
    UPDATE employees
    SET status = 'TERMINATED'
    WHERE employee_id = p_employee;

    UPDATE employees
    SET manager_id = NULL
    WHERE manager_id = p_employee;
END//

DELIMITER ;

DELIMITER //

CREATE PROCEDURE sp_review_leave(IN p_leave INT, IN p_decision VARCHAR(10))
BEGIN
    DECLARE current_status VARCHAR(10);

    IF p_decision NOT IN ('APPROVED','REJECTED') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Decision must be APPROVED or REJECTED';
    END IF;

    SELECT status INTO current_status
    FROM leave_requests
    WHERE leave_id = p_leave;

    IF current_status IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Leave request not found';
    ELSEIF current_status <> 'PENDING' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Leave request was already reviewed';
    END IF;

    UPDATE leave_requests SET status = p_decision WHERE leave_id = p_leave;
END//

DELIMITER ;