SELECT COUNT(*)
FROM (
  SELECT cust_id
  FROM sales_external
  GROUP BY cust_id
  HAVING COUNT(*) > 1
);