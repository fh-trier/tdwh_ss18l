DROP MATERIALIZED VIEW mvChannelsQuantity;

CREATE MATERIALIZED VIEW mvChannelsQuantity
  BUILD IMMEDIATE
  ENABLE QUERY REWRITE
AS
  SELECT
    re.region_name,
    ch.channel_desc,
    SUM(oi.quantity) quantity
  FROM
    dwh_regions re,
    dwh_countries co,
    dwh_customers cu,
    dwh_orders o,
    dwh_order_items oi,
    dwh_channels ch
WHERE re.region_id = co.region_id
AND co.country_id = cu.country_id
AND cu.customer_id = o.customer_id
AND o.order_id = oi.order_id
AND o.channel_id = ch.channel_id
GROUP BY re.region_name, ch.channel_desc;

SELECT *
FROM mvChannelsQuantity;