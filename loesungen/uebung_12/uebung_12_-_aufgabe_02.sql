SELECT
  j.country,
  j.city,
  SUM(j.quantity * j.price) sales_city,
  AVG(SUM(j.quantity*j.price)) OVER(PARTITION BY j.country) avg_sales_country
FROM
  meurerm.orders_json,
  JSON_TABLE(json_content,  '$' COLUMNS(
    country VARCHAR2(50) PATH '$.ShippingInstructions.Address.country',
    city VARCHAR2(50) PATH '$.ShippingInstructions.Address.city',
    NESTED PATH '$.LineItems[*]' COLUMNS(
      quantity NUMBER(5,4) PATH '$.Quantity',
      price NUMBER(5,2) PATH '$.Part.UnitPrice')
  )
) j
GROUP BY j.country, j.city;