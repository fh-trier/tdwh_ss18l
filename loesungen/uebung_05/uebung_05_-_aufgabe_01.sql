SELECT
  d.department_name,
  l.city,
  c.country_name,
  COUNT(e.employee_id) AS "Anzahl"
FROM employees e
  INNER JOIN departments d ON (e.department_id = d.department_id)
  INNER JOIN locations l ON (d.location_id = l.location_id)
  INNER JOIN countries c ON (l.country_id = c.country_id)
GROUP BY ROLLUP (d.department_name, l.city, c.country_name)