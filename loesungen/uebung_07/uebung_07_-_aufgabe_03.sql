-- Achtung:
-- Werden keine Datensätze selektiert, 
-- dann liegt es höchst wahrscheinlich daran,
-- dass das geladene Schema (oherSS18.sql) nur
-- eine abgespreckte Datenmenge besitzt.

SELECT *
FROM (
  SELECT
    pct.category_name AS "P_CATEGORY_NAME",
    ct.category_name AS "CATEGORY_NAME",
    SUM(oi.unit_price * oi.quantity) AS "UMSATZ",
    RANK() OVER(ORDER BY SUM(oi.unit_price * oi.quantity) DESC) AS "RANG"
  FROM orders o
    INNER JOIN order_items oi ON (oi.order_id = o.order_id)
    INNER JOIN product_information pi ON(pi.product_id = oi.product_id)
    INNER JOIN categories_tab ct ON (ct.category_id = pi.category_id)
    INNER JOIN categories_tab pct ON (pct.category_id = ct.parent_category_id)
    INNER JOIN customers cu ON (cu.customer_id = o.customer_id)
    INNER JOIN countries co ON (co.country_id = cu.country_id)
  WHERE co.country_name = 'Brazil'
  AND EXTRACT(YEAR FROM o.order_date) = '2014'
  GROUP BY (pct.category_name, ct.category_name)
)
WHERE RANG <= 4
ORDER BY RANG ASC;