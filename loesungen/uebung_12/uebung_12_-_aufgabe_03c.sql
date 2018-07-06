CREATE OR REPLACE VIEW "TDWH_12_03C" AS
SELECT *
FROM (
  SELECT
    cu.cust_first_name AS "FIRST",
    cu.cust_last_name AS "LAST",
    SUM(oi.quantity * oi.unit_price) AS "UMSATZ",
    RANK() OVER(ORDER BY SUM(oi.quantity * oi.unit_price) DESC) AS "RANG"
  FROM customers cu
    INNER JOIN orders o ON (o.customer_id = cu.customer_id)
    INNER JOIN order_items oi ON (oi.order_id = o.order_id)
    INNER JOIN product_information pi ON (pi.product_id = oi.product_id)
    INNER JOIN categories_tab ct1 ON (ct1.category_id = pi.category_id)
    INNER JOIN categories_tab ct2 ON (ct2.category_id = ct1.parent_category_id)
    INNER JOIN countries co ON (co.country_id = cu.country_id)
    INNER JOIN regions r ON (r.region_id = co.region_id)
  WHERE UPPER(r.region_name) = UPPER('middle east and africa')
  AND EXTRACT(YEAR FROM o.order_date) = '2014'
  AND ct2.category_name LIKE 'software'
  GROUP BY
    cu.cust_first_name,
    cu.cust_last_name
)
WHERE rang = 1;