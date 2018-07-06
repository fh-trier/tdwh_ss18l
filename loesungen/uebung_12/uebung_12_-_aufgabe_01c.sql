SELECT COUNT(*)
FROM (
  SELECT COUNT(*)
  FROM tdwh_12_01 t
  GROUP BY t.cust_id
  HAVING COUNT(*) >= 2
);