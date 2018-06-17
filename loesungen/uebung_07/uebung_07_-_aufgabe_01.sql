SELECT
  o.order_id,
  pi.product_name,
  oi.quantity, 
  ct.category_name,
  SUM(oi.quantity) OVER(PARTITION BY ct.parent_category_id) AS "SUM_PARENT_CATEGORY"
FROM orders o
  INNER JOIN order_items oi ON (oi.order_id = o.order_id)
  INNER JOIN product_information pi ON(pi.product_id = oi.product_id)
  INNER JOIN categories_tab ct ON (ct.category_id = pi.category_id);