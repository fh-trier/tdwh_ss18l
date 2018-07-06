CREATE OR REPLACE VIEW "TDWH_12_03D" AS
SELECT
  d.department_name AS "DEPT_NAME",
  COUNT(e.employee_id) AS "EMPLOYEES",
  SUM(e.salary) AS "SALARY"
FROM departments d
  INNER JOIN employees e ON (d.department_id = e.department_id)
GROUP BY GROUPING SETS(
  (d.department_name),
  ()
);
