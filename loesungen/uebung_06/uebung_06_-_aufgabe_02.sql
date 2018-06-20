-- GROUPING SETS
CREATE OR REPLACE VIEW "REPORT_62" AS
SELECT
  DECODE(GROUPING(l.city), 1, '-all-', l.city) AS "CITY",
  DECODE(GROUPING(d.department_name), 1, '-all-', d.department_name) AS "DEPARTMENT",
  DECODE(GROUPING(j.job_title), 1, '-all-', j.job_title) AS "JOB",
  NVL(CONCAT(e.first_name, CONCAT(' ', e.last_name)), '-all-') AS "NAME",
  SUM(e.salary) AS "SALARY"
FROM departments d
  INNER JOIN employees e ON (e.department_id = d.department_id)
  INNER JOIN locations l ON (l.location_id = d.location_id)
  INNER JOIN jobs j ON (j.job_id = e.job_id)
GROUP BY GROUPING SETS (
  (l.city, d.department_name, CONCAT(e.first_name, CONCAT(' ', e.last_name))),
  (l.city, d.department_name),
  (l.city),
  (j.job_title),
  ()
)
ORDER BY
  l.city,
  d.department_name,
  j.job_title,
  CONCAT(e.first_name, CONCAT(' ', e.last_name)
);