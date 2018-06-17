SELECT
  dep.department_id,
  dep.department_name,
  COUNT(emp.employee_id) count_emp,
  NVL(SUM(emp.salary), 0) sum_sal
FROM departments dep
  LEFT JOIN employees emp ON (dep.department_id = emp.department_id)
GROUP BY ROLLUP(dep.department_id, dep.department_name);