CREATE OR REPLACE VIEW "TDWH_12_03B" AS
SELECT
  d.department_id AS "DEPT_ID",
  d.department_name AS "DEPT_NAME",
  e.first_name AS "FIRST",
  e.last_name AS "LAST",
  j.job_id AS "JOB_ID",
  j.job_title AS "JOB_NAME",
  e.salary AS "SALARY",
  MAX(salary) OVER(PARTITION BY d.department_id, j.job_id) AS "MAX_DEPT_JOB_SALARY",
  AVG(salary) OVER(PARTITION BY d.department_id, j.job_id) AS "AVG_DEPT_JOB_SALARY"
FROM employees e
  INNER JOIN departments d ON (d.department_id = e.department_id)
  INNER JOIN jobs j ON (j.job_id = e.job_id);