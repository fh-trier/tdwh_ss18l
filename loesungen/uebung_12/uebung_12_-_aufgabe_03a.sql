CREATE OR REPLACE VIEW "TDWH_12_03A" AS
SELECT *
FROM (
  SELECT
    ch.channel_class AS "CHANNEL_CLASS",
    SUM(oi.quantity * oi.unit_price) AS "UMSATZ",
    RANK() OVER(ORDER BY SUM(oi.quantity * oi.unit_price) DESC) AS "RANG"
  FROM channels ch
    INNER JOIN orders o ON (o.channel_id = ch.channel_id)
    INNER JOIN order_items oi ON (oi.order_id = o.order_id)
  WHERE EXTRACT(YEAR FROM o.order_date) = '2010'
  GROUP BY
    ch.channel_class
)
WHERE "RANG" <= 3;