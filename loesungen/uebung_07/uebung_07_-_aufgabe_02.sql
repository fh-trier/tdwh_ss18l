SELECT
  dep.department_id,
  dep.department_name,
  ROUND(NVL(AVG(emp.salary), 0), 2) avg_sal,
  NTILE(3) OVER(ORDER BY AVG(emp.salary) nulls FIRST) class
FROM departments dep
  LEFT JOIN employees emp ON (dep.department_id = emp.department_id)
GROUP BY department_id, dep.department_name;