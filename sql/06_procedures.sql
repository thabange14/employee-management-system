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