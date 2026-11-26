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