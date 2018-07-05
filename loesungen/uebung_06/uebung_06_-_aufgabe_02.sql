-- GROUPING SETS
CREATE OR REPLACE VIEW "TDWH_06_02" AS
SELECT
  DECODE(GROUPING(l.city), 1, '-all', l.city) AS "CITY",
  DECODE(GROUPING(d.department_name ), 1, '-all', d.department_name) AS "DEPARTMENT",
  NVL(e.first_name || ' ' || e.last_name, '-all-') AS "NAME",
  DECODE(GROUPING(j.job_title), 1, '-all', j.job_title) AS "JOB",
  SUM(e.salary) AS "SALARY"
FROM employees e
  INNER JOIN departments d ON (d.department_id = e.department_id)
  INNER JOIN locations l ON (l.location_id = d.location_id)
  INNER JOIN countries co ON (co.country_id = l.country_id)
  INNER JOIN jobs j ON (j.job_id = e.job_id)
GROUP BY GROUPING SETS(
  (l.city, d.department_name, e.first_name || ' ' || e.last_name),
  (l.city, d.department_name),
  (l.city),
  (j.job_title),
  ()
);
