SELECT
  order_id,
  order_date,
  order_total,
  SUM(order_total) OVER(PARTITION BY TO_CHAR(order_date,'YYYY ')) sumYear
FROM orders;
