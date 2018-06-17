SELECT *
FROM (
  SELECT
    employee_id,
    last_name,
    COUNT(*) anz,
    RANK() OVER(ORDER BY COUNT(*) DESC) rang
  FROM employees e
    INNER JOIN orders o ON (o.sales_rep_id = e.employee_id)
  GROUP BY employee_id, last_name
)
WHERE rang <=2;