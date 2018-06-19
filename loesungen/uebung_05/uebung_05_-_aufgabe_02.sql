SELECT
  NVL(l.city, '-all-') AS "City",
  NVL(d.department_name, '-all-') AS "Department",
  NVL(jo.job_title, '-all-') AS "Job",
  NVL(emp.first_name || ' ' || emp.last_name, '-all-') AS "Name",
  NVL(emp.salary) AS "Salary"
FROM employees e
  INNER JOIN departments d ON (e.department_id = d.department_id)
  INNER JOIN locations l ON (d.location_id = l.location_id)
  INNER JOIN jobs j ON (e.job_id = j.job_id)
GROUP BY GROUPING SETS (
 (l.city, d.department_name, e.first_name || ' ' || e.last_name),
 (l.city, d.department_name),
 (l.city),
 (j.job_title),
 ());