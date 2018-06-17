SELECT
  dc.region_name AS "REGION",
  dc.country_name AS "COUNTRY",
  SUM(f.quantity*f.unit_price) AS "AMOUNT_SOLD",
  SUM(f.quantity) AS "QUANTITY"
FROM facts f
  INNER JOIN dim_customer dc ON (f.cust_id = dc.id)
  INNER JOIN dim_date dd ON (f.date_id = dd.id)
WHERE dd.yearnumber = 2012
GROUP BY dc.region_name, dc.country_name;

SELECT
  dd.yearnumber AS "YEAR_NUM",
  dp.category_name AS "CATEGORY",
  dp.subcategory_name AS "SUB_CATEGORY",
  SUM(f.quantity)
FROM facts f
  INNER JOIN dim_product dp ON (f.prod_id = dp.id)
  INNER JOIN dim_date dd ON (f.date_id = dd.id)
  INNER JOIN dim_customer dc ON (f.cust_id = dc.id)
WHERE Dc.Region_Name in ('Asia','Europe')
GROUP BY ROLLUP (
  dp.category_name,
  dp.subcategory_name
), dd.yearnumber;