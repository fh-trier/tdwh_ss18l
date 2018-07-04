-- Achtung:
-- Werden keine Datensätze selektiert,
-- dann liegt es höchst wahrscheinlich daran,
-- dass das geladene Schema (oherSS18.sql) nur
-- eine abgespreckte Datenmenge besitzt.

SELECT *
FROM (
  SELECT
    ct2.category_name AS "PAR_CAT_NAME",
    ct1.category_name AS "CAT_NAME",
    SUM(o.order_total) AS "UMSATZ",
    RANK() OVER(ORDER BY SUM(o.order_total) DESC) AS "RANG"
  FROM orders o
    INNER JOIN order_items oi ON (oi.order_id = o.order_id)
    INNER JOIN product_information pi ON (pi.product_id = oi.product_id)
    INNER JOIN categories_tab ct1 ON (ct1.category_id = pi.category_id)
    INNER JOIN categories_tab ct2 ON (ct2.category_id = ct1.parent_category_id)
    INNER JOIN customers cu ON (cu.customer_id = o.customer_id)
    INNER JOIN countries co ON (co.country_id = cu.country_id)
  WHERE EXTRACT(YEAR FROM o.order_date) IN ('2014')
  AND co.country_name IN ('Brazil')
  GROUP BY
    ct2.category_name,
    ct1.category_name
)
WHERE rang <= 4 ASC;