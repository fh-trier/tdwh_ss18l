SELECT
  emp.employee_id,
  emp.first_name,
  emp.last_name,
  COUNT(jh.employee_id) prev_jobs,
  MAX(jh.end_date)+1 start_act_job,
  jo.job_title act_job
FROM employees emp
  INNER JOIN job_history jh ON (emp.employee_id = jh.employee_id)
  INNER JOIN jobs jo ON(emp.job_id = jo.job_id)
GROUP BY emp.employee_id, emp.first_name, emp.last_name, jo.job_title
HAVING COUNT(jh.employee_id) > 1;