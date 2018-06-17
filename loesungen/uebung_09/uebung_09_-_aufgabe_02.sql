INSERT INTO orders
SELECT
  order_id,
  order_date,
  channel_id,
  customer_id,
  order_status,
  SUM(pi.list_price*quantity),
  sales_rep_id,
  null
FROM orders_ext oe
  INNER JOIN product_information pi ON (oe.product_id = pi.product_id)
GROUP BY
  order_id,
  order_date,
  channel_id,
  customer_id,
  order_status,
  sales_rep_id;

INSERT INTO order_items
SELECT
  order_id,
  line_item_id,
  pi.product_id,
  pi.list_price,
  quantity
FROM orders_ext oe
  INNER JOIN product_information pi ON (oe.product_id = pi.product_id);