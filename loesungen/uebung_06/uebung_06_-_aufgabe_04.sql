-- Pivot Tabellen müssen immer als
-- eigene SELECT-Abfrage geschatet werden.
SELECT *
FROM (
  SELECT
    j.job_title AS "JOB",
    e.employee_id AS "EMP_NO",
    c.country_name AS "COUNTRY"
  FROM employees e
    INNER JOIN jobs j ON (e.job_id = j.job_id)
    INNER JOIN departments d ON (e.department_id = d.department_id)
    INNER JOIN locations l ON (d.location_id = l.location_id)
    INNER JOIN countries c ON (l.country_id = c.country_id)
)
PIVOT (
  COUNT(emp_no) FOR country IN ('United Kingdom', 'United States of America', 'Germany', 'Kuwait','Canada', 'Singapore')
)
ORDER BY job;