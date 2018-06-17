SELECT *
FROM (
  SELECT
    ct2.category_name, EXTRACT(YEAR FROM o.order_date) jahr,
    o.order_total
  FROM orders o
    INNER JOIN order_items oi ON (o.order_id = oi.order_id
    INNER JOIN product_informatiON pi ON (oi.Product_Id = pi.Product_Id)
    INNER JOIN categories_tab ct ON (pi.category_id = ct.category_id)
    INNER JOIN categories_tab ct2 ON (ct.parent_category_id = ct2.category_id)
)
PIVOT (
  SUM(order_total) FOR (jahr) IN (
    2014 AS "2014",
    2015 AS "2015",
    2016 as "2016"
  )
);