SELECT
  TO_CHAR(order_date, 'YYYY-MM') month,
  SUM(quantity*unit_price) sales,
  DECODE(NTILE(3) OVER(ORDER BY SUM(quantity*unit_price)),
    1, 'klein',
    2, 'mittel',
    3, 'gross'
  ) klasse
FROM orders a
  INNER JOIN order_items b ON (a.order_id = b.order_id
  INNER JOIN product_information c ON (b.product_id = c.product_id
  INNER JOIN categories_tab d ON (c.category_id = d.category_id)
  INNER JOIN categories_tab e ON (d.parent_category_id = e.category_id)
WHERE EXTRACT(YEAR FROM order_Date) = 2010
AND e.category_name = 'software'
GROUP BY TO_CHAR(order_date, 'YYYY-MM')
ORDER BY TO_CHAR(order_date, 'YYYY-MM');