SELECT
  ct2.category_name,
  SUM(CASE WHEN EXTRACT(YEAR FROM o.order_date) = 2014 THEN o.order_total ELSE 0 END) "2014",
  SUM(CASE WHEN EXTRACT(YEAR FROM o.order_date) = 2015 THEN o.order_total ELSE 0 END) "2015",
  SUM(CASE WHEN EXTRACT(YEAR FROM o.order_date) = 2016 THEN o.order_total ELSE 0 END) "2016"
FROM orders o
  INNER JOIN order_items oi ON (o.order_id = oi.order_id
  INNER JOIN product_informatiON pi ON (oi.Product_Id = pi.Product_Id)
  INNER JOIN categories_tab ct ON (pi.category_id = ct.category_id)
  INNER JOIN categories_tab ct2 ON (ct.parent_category_id = ct2.category_id)
GROUP BY ct2.category_name;