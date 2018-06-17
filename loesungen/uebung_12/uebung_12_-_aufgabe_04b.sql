ALTER SESSION SET QUERY_REWRITE_ENABLED = TRUE;

EXPLAIN PLAN FOR
  SELECT
    re.region_name,
    ch.channel_desc,
    SUM(oi.quantity)
  FROM dwh_regions re
    INNER JOIN dwh_countries co ON (re.region_id = co.region_id)
    INNER JOIN dwh_customers cu ON (co.country_id = cu.country_id)
    INNER JOIN dwh_orders o ON (cu.customer_id = o.customer_id)
    INNER JOIN dwh_order_items oi ON (o.order_id = oi.order_id)
    INNER JOIN dwh_channels ch ON (o.channel_id = ch.channel_id)
  GROUP BY re.region_name, ch.channel_desc;

SELECT *
FROM TABLE(dbms_xplan.display());