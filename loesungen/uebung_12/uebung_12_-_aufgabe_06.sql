SELECT
  last_name,
  department_id,
  job_id,
  salary,
  MAX(salary) OVER(PARTITION BY department_id, job_id) maxSal
FROM employees;