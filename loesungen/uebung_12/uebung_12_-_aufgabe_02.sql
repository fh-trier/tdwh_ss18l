CREATE OR REPLACE VIEW "TDWH_12_02" AS
SELECT
  jt.country,
  jt.city,
  SUM(jt.quantity * jt.unit_price) AS "UMSATZ",
  AVG(SUM(jt.quantity * jt.unit_price)) OVER (PARTITION BY jt.country) AS "AVG_COUNTRY"
FROM
  orders_json oj,
  JSON_TABLE(
    oj.json_content,
    '$' COLUMNS (
      "COUNTRY" VARCHAR2(30) PATH '$.ShippingInstructions.Address.country',
      "CITY" VARCHAR2(30) PATH '$.ShippingInstructions.Address.city',
      NESTED PATH '$.LineItems[*]' COLUMNS (
        "QUANTITY" VARCHAR2(30) PATH '$.Quantity',
        "UNIT_PRICE" NUMBER(8,2) PATH '$.Part.UnitPrice'
      )
    )
  ) jt
GROUP BY jt.country, jt.city;
