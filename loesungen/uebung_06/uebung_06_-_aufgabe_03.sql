-- Achtung:
-- Falls keine Datensätze ausgegeben werden liegt das wahrscheinlich daran,
-- dass durch die Datei oehr_dwhSS18.sql nur das kleine DWH-Schema importiert wurde.
-- Erzeuge zur Lösung Synonyme oder Views die auf das DWH-Schema referenzieren!
CREATE OR REPLACE VIEW "TDWH_06_03" AS
SELECT
  EXTRACT(YEAR FROM o.order_date) AS "YEAR",
  co.country_name AS "COUNTRY",
  r.region_name AS "REGION",
  SUM(o.order_total) AS "SALES"
FROM orders o
  INNER JOIN customers cu ON (cu.customer_id = o.customer_id)
  INNER JOIN countries co ON (co.country_id = cu.country_id)
  INNER JOIN regions r ON (r.region_id = co.region_id)
WHERE EXTRACT(YEAR FROM o.order_date) IN ('2010', '2011', '2012')
GROUP BY GROUPING SETS (
  (EXTRACT(YEAR FROM o.order_date), co.country_name, r.region_name),
  (co.country_name, r.region_name),
  (EXTRACT(YEAR FROM o.order_date)),
  ()
);
