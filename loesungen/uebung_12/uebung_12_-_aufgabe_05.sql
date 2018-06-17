SELECT
  order_id,
  order_date,
  order_total,
  LAG(order_total) OVER(ORDER BY order_date) orderTotalPrev,
  AVG(order_total) OVER(ORDER BY order_date ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) orderAVG
FROM orders;
