SELECT *
FROM (
  SELECT
    ch.channel_id,
    ch.channel_desc,
    SUM(oi.unit_price*oi.quantity) sales,
    RANK() OVER(ORDER BY SUM(oi.unit_price*oi.quantity) DESC) rang
  FROM channels ch
    INNER JOIN orders o ON (ch.channel_id = o.channel_id)
    INNER JOIN order_items oi ON (o.order_id = oi.order_id)
  WHERE EXTRACT(YEAR FROM o.order_date) = 2010
  GROUP BY ch.channel_id, ch.channel_desc
)
WHERE rang < 4;