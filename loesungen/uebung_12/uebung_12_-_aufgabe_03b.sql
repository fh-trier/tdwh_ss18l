SELECT
  department_id,
  job_id,
  employee_id,
  first_name,
  last_name,
  salary,
  MAX(salary) OVER(PARTITION BY job_id, department_id) max_sal_dep_job
FROM employees
ORDER BY department_id, job_id, employee_id;