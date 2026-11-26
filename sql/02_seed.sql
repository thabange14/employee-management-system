USE ems;

INSERT INTO departments (name, location) VALUES
('Engineering','Gaborone'),
('Human Resources','Gaborone'),
('Finance','Francistown'),
('Sales','Maun');

INSERT INTO jobs (title, min_salary, max_salary) VALUES
('CTO',60000,120000),
('Software Engineer',20000,60000),
('HR Manager',25000,55000),
('Accountant',18000,45000),
('Sales Executive',12000,40000),
('Finance Manager',30000,70000);


-- Managers 
INSERT INTO employees (first_name,last_name,email,phone,hire_date,job_id,department_id,manager_id,salary) VALUES
('Thabo','Mokoena','thabo.mokoena@company.com','+26771000001','2018-02-01',1,1,NULL,95000),
('Neo','Kgosi','neo.kgosi@company.com','+26771000002','2019-05-15',3,2,NULL,42000),
('Lesego','Dube','lesego.dube@company.com','+26771000003','2019-08-20',6,3,NULL,55000);

-- Staff who report to  managers
INSERT INTO employees (first_name,last_name,email,phone,hire_date,job_id,department_id,manager_id,salary) VALUES
('Kabelo','Sithole','kabelo.sithole@company.com','+26771000004','2021-01-10',2,1,1,38000),
('Mpho','Tau','mpho.tau@company.com','+26771000005','2022-03-01',2,1,1,32000),
('Boitumelo','Molefe','boitumelo.molefe@company.com','+26771000006','2023-06-12',2,1,1,24000),
('Tebogo','Ramotswe','tebogo.ramotswe@company.com','+26771000007','2020-09-01',4,3,3,28000);

INSERT INTO leave_requests (employee_id, leave_type, start_date, end_date, status, reason) VALUES
(4,'ANNUAL','2026-12-15','2026-12-31','APPROVED','Holiday'),
(5,'SICK','2026-11-24','2026-11-25','APPROVED','Flu'),
(6,'ANNUAL','2026-12-01','2026-12-05','PENDING','Family event');

-- October payslip for every employee: 15% deductions, no bonus
INSERT INTO payroll (employee_id, pay_month, base_salary, bonus, deductions)
SELECT employee_id, '2026-10-01', salary, 0, ROUND(salary * 0.15, 2)
FROM employees;

INSERT INTO attendance (employee_id, work_date, check_in, check_out, status) VALUES
(4,'2026-11-23','08:00','17:00','PRESENT'),
(5,'2026-11-23','08:45','17:10','LATE'),
(6,'2026-11-23',NULL,NULL,'REMOTE'),
(4,'2026-11-24','07:55','17:05','PRESENT'),
(5,'2026-11-24',NULL,NULL,'ABSENT'),
(6,'2026-11-24','08:00','16:50','PRESENT');