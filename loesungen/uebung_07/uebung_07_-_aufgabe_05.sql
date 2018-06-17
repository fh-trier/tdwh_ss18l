SELECT
  country_name,
  channel_desc,
  SUM(a.order_total) sales,
  RANK() OVER (PARTITION BY c.country_name ORDER BY SUM(a.order_total) DESC) rang
FROM dwh.orders a
  INNER JOIN dwh.customers b ON (a.customer_id = b.customer_id)
  INNER JOIN dwh.countries c ON (b.country_id = c.country_id)
  INNER JOIN dwh.channels d ON (a.channel_id = d.channel_id)
WHERE EXTRACT(YEAR FROM order_date) = 2008
AND EXTRACT(MONTH FROM order_date) BETWEEN 3 AND 6
GROUP BY country_name, channel_desc;