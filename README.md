# Employee Management System (SQL)

A MySQL database project for managing employees, departments, jobs and leave requests.

## Features
- Tables with primary keys, foreign keys and CHECK rules
- Employee-to-manager relationship (self-referencing table)
- A view that joins employee, job, department and manager details
- A trigger that logs every salary change
- A stored procedure to give percentage raises
- Example queries: JOINs, GROUP BY, filtering

## Files
| File | Purpose |
|------|---------|
| `sql/01_schema.sql` | Creates the database and tables |
| `sql/02_seed.sql` | Adds sample data |
| `sql/03_queries.sql` | Example reports |
| `sql/04_views.sql` | Employee details view |
| `sql/05_triggers.sql` | Salary audit trigger |
| `sql/06_procedures.sql` | Give-raise procedure |

## How to run
```bash
sudo service mysql start
sudo mysql < sql/01_schema.sql
sudo mysql < sql/02_seed.sql
sudo mysql < sql/04_views.sql
sudo mysql < sql/05_triggers.sql
sudo mysql < sql/06_procedures.sql
sudo mysql < sql/03_queries.sql
```

## Try it
```sql
CALL sp_give_raise(4, 10);
SELECT * FROM salary_audit;
```