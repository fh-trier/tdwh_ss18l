CREATE OR REPLACE VIEW "TDWH_07_06" AS
SELECT *
FROM (
  SELECT
    product_id,
    product_name,
    anzahl,
    ROUND(AVG(anzahl) OVER(PARTITION BY parent_category_id), 2) AS "AVG_VALUE"
  FROM (
    SELECT
      pi.product_id,
      pi.product_name,
      ct.parent_category_id,
      SUM(oi.quantity) AS "ANZAHL"
    FROM order_items oi
      INNER JOIN product_information pi ON (pi.product_id = oi.product_id)
      INNER JOIN categories_tab ct ON (ct.category_id = pi.category_id)
    GROUP BY pi.product_id, pi.product_name, ct.parent_category_id
  )
)
WHERE anzahl > avg_value
ORDER BY product_id;
