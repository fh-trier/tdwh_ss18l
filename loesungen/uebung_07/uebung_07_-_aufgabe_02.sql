CREATE OR REPLACE VIEW "REPORT_72" AS
SELECT
  d.department_id AS "DEPT_ID",
  d.department_name AS "DEPT_NAME",
  NVL(ROUND(AVG(e.salary),2),0) AS "AVG_SAL",
  NTILE(3) OVER(ORDER BY AVG(e.salary) NULLS FIRST) AS "CLASS"
FROM departments d
  INNER JOIN employees e ON (e.department_id = d.department_id)
GROUP BY
  d.department_id,
  d.department_name
ORDER BY
  "CLASS";