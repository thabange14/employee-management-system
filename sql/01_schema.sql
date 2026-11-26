DROP DATABASE IF EXISTS ems;
CREATE DATABASE ems CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE ems;

CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    name          VARCHAR(100) NOT NULL UNIQUE,
    location      VARCHAR(100),
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE jobs (
    job_id     INT AUTO_INCREMENT PRIMARY KEY,
    title      VARCHAR(100) NOT NULL UNIQUE,
    min_salary DECIMAL(12,2) NOT NULL,
    max_salary DECIMAL(12,2) NOT NULL,
    CONSTRAINT chk_salary_range CHECK (max_salary >= min_salary)
);

CREATE TABLE employees (
    employee_id   INT AUTO_INCREMENT PRIMARY KEY,
    first_name    VARCHAR(50)  NOT NULL,
    last_name     VARCHAR(50)  NOT NULL,
    email         VARCHAR(120) NOT NULL UNIQUE,
    phone         VARCHAR(30),
    hire_date     DATE NOT NULL,
    job_id        INT NOT NULL,
    department_id INT NOT NULL,
    manager_id    INT NULL,
    salary        DECIMAL(12,2) NOT NULL CHECK (salary > 0),
    status        ENUM('ACTIVE','ON_LEAVE','TERMINATED') NOT NULL DEFAULT 'ACTIVE',
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (job_id)        REFERENCES jobs(job_id),
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (manager_id)    REFERENCES employees(employee_id) ON DELETE SET NULL
);

CREATE TABLE leave_requests (
    leave_id    INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    leave_type  ENUM('ANNUAL','SICK','MATERNITY','PATERNITY','UNPAID') NOT NULL,
    start_date  DATE NOT NULL,
    end_date    DATE NOT NULL,
    status      ENUM('PENDING','APPROVED','REJECTED') NOT NULL DEFAULT 'PENDING',
    reason      VARCHAR(255),
    CONSTRAINT chk_leave_dates CHECK (end_date >= start_date),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE
);

CREATE TABLE salary_audit (
    audit_id    INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    old_salary  DECIMAL(12,2),
    new_salary  DECIMAL(12,2),
    changed_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE payroll (
    payroll_id  INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    pay_month   DATE NOT NULL,
    base_salary DECIMAL(12,2) NOT NULL,
    bonus       DECIMAL(12,2) NOT NULL DEFAULT 0,
    deductions  DECIMAL(12,2) NOT NULL DEFAULT 0,
    net_pay     DECIMAL(12,2) GENERATED ALWAYS AS (base_salary + bonus - deductions) STORED,
    UNIQUE KEY uq_employee_month (employee_id, pay_month),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE
);

CREATE TABLE attendance (
    attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id   INT NOT NULL,
    work_date     DATE NOT NULL,
    check_in      TIME,
    check_out     TIME,
    status        ENUM('PRESENT','ABSENT','LATE','REMOTE') NOT NULL DEFAULT 'PRESENT',
    UNIQUE KEY uq_employee_day (employee_id, work_date),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE
);