-- DELETE
DELETE FROM orders o
WHERE o.order_id IN (
  SELECT order_id
  FROM TDWH_09_01
);

DELETE FROM order_items oi
WHERE oi.order_id IN (
  SELECT order_id
  FROM TDWH_09_01
);

-- INSERT
INSERT INTO orders o
SELECT
  oe.order_id,
  oe.order_date,
  oe.channel_id,
  oe.customer_id,
  oe.order_status,
  SUM(pi.list_price * oe.quantity),
  oe.sales_rep,
  NULL
FROM tdwh_09_01 oe
  INNER JOIN product_information pi ON (pi.order_id = oe.order_id)
GROUP BY
    oe.order_id,
  oe.order_date,
  oe.channel_id,
  oe.customer_id,
  oe.order_status,
  oe.sales_rep;

INSERT INTO order_items oi
SELECT
  oe.order_id,
  oe.line_item_id,
  oe.product_id,
  pi.list_price,
  oe.quantity,
  NULL
FROM tdwh_09_01 oe
  INNER JOIN product_information pi ON (pi.product_id = oe.product_id);