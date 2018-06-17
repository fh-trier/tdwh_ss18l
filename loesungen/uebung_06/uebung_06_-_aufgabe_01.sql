SELECT 
  d.department_name AS "DEPARTMENT",
  l.city AS "CITY",
  c.country_name AS "COUNTRY",
  COUNT(e.employee_id)
FROM employees e
  INNER JOIN departments d ON (d.department_id = e.department_id)
  INNER JOIN locations l ON (l.location_id = d.location_id)
  INNER JOIN countries c ON (c.country_id = l.country_id)
GROUP BY ROLLUP(d.department_name, l.city, c.country_name)
ORDER BY d.department_name, l.city, c.country_name;