-- Pivot Tabellen müssen immer als
-- eigene SELECT-Abfrage geschatet werden.
CREATE OR REPLACE VIEW "TDWH_06_04" AS
SELECT *
FROM (
  SELECT
    j.job_title AS "JOB",
    e.employee_id AS "EMP_NO",
    co.country_name AS "COUNTRY"
  FROM jobs j
    INNER JOIN employees e ON (e.job_id = j.job_id)
    INNER JOIN departments d ON (d.department_id = e.department_id)
    INNER JOIN locations l ON (l.location_id = d.location_id)
    INNER JOIN countries co ON (co.country_id = l.country_id)
)
PIVOT (
  COUNT(emp_no) FOR country IN (
    'United States of America',
    'United Kingdom',
    'Germany',
    'Kuwait',
    'Canada',
    'Singapore'
  )
)
ORDER BY job;