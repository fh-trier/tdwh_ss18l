-- ORDERS
INSERT INTO orders
SELECT
  order_id,
  order_date,
  channel_id,
  customer_id,
  order_status,
  SUM(pi.list_price * r.quantity),
  r.sales_rep_id,
  NULL
FROM report_91 r
  INNER JOIN product_information pi ON (pi.product_id = r.product_id)
GROUP BY
  order_id,
  order_date,
  channel_id,
  customer_id,
  order_status,
  r.sales_rep_id;

-- ORDER_ITEMS
INSERT INTO order_items
SELECT
  r.order_id,
  r.line_item_id,
  pi.product_id,
  pi.list_price,
  r.quantity,
  NULL
FROM report_91 r
  INNER JOIN product_information pi ON (pi.product_id = r.product_id);