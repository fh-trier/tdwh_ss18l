CREATE OR REPLACE VIEW "REPORT_61" AS
SELECT
  d.department_name AS "DEPARTMENT_NAME",
  l.city AS "CITY",
  co.country_name AS "COUNTRY_NAME",
  COUNT(e.employee_id) AS "COUNT"
FROM employees e
  INNER JOIN departments d ON (d.department_id = e.department_id)
  INNER JOIN locations l ON (d.location_id = l.location_id)
  INNER JOIN countries co ON (co.country_id = l.country_id)
GROUP BY GROUPING SETS(
  (d.department_name, l.city, co.country_name),
  (d.department_name, l.city),
  (d.department_name),
  ()
)
ORDER BY
  d.department_name,
  l.city,
  co.country_name;