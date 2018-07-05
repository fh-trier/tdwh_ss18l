CREATE OR REPLACE VIEW "TDWH_07_05" AS
SELECT
  co.country_name AS "COUNTRY",
  ca.channel_desc AS "CHANNEL_DESC",
  SUM(o.order_total) AS "SALES",
  RANK() OVER(PARTITION BY co.country_name ORDER BY SUM(o.order_total) DESC) AS "RANG"
FROM orders o
  INNER JOIN customers cu ON (cu.customer_id = o.customer_id)
  INNER JOIN countries co ON (co.country_id = cu.country_id)
  INNER JOIN channels ca ON (ca.channel_id = o.channel_id)
WHERE EXTRACT(YEAR FROM o.order_date) IN ('2008')
AND EXTRACT(MONTH FROM o.order_date) BETWEEN 3 AND 6
GROUP BY
  co.country_name,
  ca.channel_desc;