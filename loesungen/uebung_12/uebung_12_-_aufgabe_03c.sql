SELECT *
FROM (
  SELECT
    cu.customer_id,
    cu.cust_first_name,
    cu.cust_last_name,
    SUM(oi.quantity*oi.unit_price) sales,
    RANK() OVER(ORDER BY SUM(oi.quantity*oi.unit_price) DESC) rang
  FROM regions re
    INNER JOIN dwh.countries co ON (re.region_id = co.region_id)
    INNER JOIN dwh.customers cu ON (co.country_id = cu.country_id)
    INNER JOIN dwh.orders o ON (cu.customer_id = o.customer_id)
    INNER JOIN dwh.order_items oi ON (o.order_id = oi.order_id)
    INNER JOIN dwh.product_information pi ON (oi.product_id = pi.product_id)
    INNER JOIN dwh.categories_tab scat ON (pi.category_id = scat.category_id)
    INNER JOIN dwh.categories_tab cat ON (scat.parent_category_id = cat.category_id)
  WHERE EXTRACT(YEAR FROM o.order_date) = 2014
  AND re.region_name = 'Middle East and Africa'
  AND cat.category_name = 'software'
  GROUP BY cu.customer_id, cu.cust_first_name, cu.cust_last_name
)
WHERE rang = 1;