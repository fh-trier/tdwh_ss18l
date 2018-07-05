CREATE OR REPLACE VIEW "TDWH_07_01" AS
SELECT
  o.order_id AS "ORDER_ID",
  ct2.category_id AS "PAR_CAT_ID",
  ct2.category_name AS "PAT_CAT_NAME",
  ct1.category_id AS "CAT_ID",
  ct1.category_name AS "CAT_NAME",
  pi.product_name AS "PRODUCT_NAME",
  oi.quantity AS "QUANTITY",
  SUM(oi.quantity) OVER(PARTITION BY ct2.category_id) AS "SUMPERPARCAT"
FROM orders o
  INNER JOIN order_items oi ON (oi.order_id = o.order_id)
  INNER JOIN product_information pi ON (pi.product_id = oi.product_id)
  INNER JOIN categories_tab ct1 ON (ct1.category_id = pi.category_id)
  INNER JOIN categories_tab ct2 ON (ct2.category_id = ct1.parent_category_id);