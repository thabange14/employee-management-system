# Employee Management System (SQL)

A MySQL database project for managing employees, departments, jobs, attendance, leave and payroll.

## Features
- Tables with primary keys, foreign keys, CHECK rules and a generated `net_pay` column
- Employee-to-manager relationship (self-referencing table)
- A view joining employee, job, department and manager details
- Triggers: salary change audit log and salary range validation
- Stored procedures: give raise, terminate employee, generate monthly payroll, approve or reject leave
- Reports: JOINs, GROUP BY, subqueries, attendance and payroll summaries
- Recursive CTE org chart

## Files
| File | Purpose |
|------|---------|
| `setup.sh` | Rebuilds the whole database in one command |
| `sql/01_schema.sql` | Creates the database and tables |
| `sql/02_seed.sql` | Adds sample data |
| `sql/03_queries.sql` | Example reports |
| `sql/04_views.sql` | Employee details view |
| `sql/05_triggers.sql` | Salary audit and validation triggers |
| `sql/06_procedures.sql` | Raise, terminate, payroll and leave procedures |
| `sql/07_org_chart.sql` | Company reporting tree |

## How to run
```bash
bash setup.sh
sudo mysql < sql/03_queries.sql
sudo mysql < sql/07_org_chart.sql
```

## Try it
```sql
CALL sp_give_raise(4, 10);
CALL sp_review_leave(3, 'APPROVED');
CALL sp_generate_payroll('2026-11-15');
SELECT * FROM salary_audit;
```

## Built with
MySQL 8, developed in GitHub Codespaces.