CREATE OR REPLACE VIEW "TDWH_10_04" AS
SELECT *
FROM (
  SELECT
    "FIRSTNAME" || ' ' || "LASTNAME" AS "NAME",
    SUBSTR(registered, 0, 7) AS "MONTH",
    SUM(quantity) AS "QUANT_PER_CUST",
    RANK() OVER(PARTITION BY SUBSTR("REGISTERED", 0, 7) ORDER BY SUM(quantity) DESC) AS "RANG"
  FROM (
    SELECT jt.*
    FROM
      weborders w,
      JSON_TABLE(
        w.JSONORD, '$' COLUMNS (
          "FIRSTNAME" VARCHAR2(30) PATH '$.firstname',
          "LASTNAME" VARCHAR2(30) PATH '$.lastname',
          "PHONE" VARCHAR2(30) PATH '$.phone',
          "REGISTERED" VARCHAR(30) PATH '$.registered',
          NESTED PATH '$.items[*]' COLUMNS(
            "PROD_ID" VARCHAR2(30) PATH '$.product_id',
            "QUANTITY" VARCHAR2(30) PATH '$.quantity'
          )
        )
      ) jt
  )
  GROUP BY
    "FIRSTNAME" || ' ' || "LASTNAME",
    SUBSTR(registered, 0, 7)
)
WHERE "RANG" <= 2
AND SUBSTR("MONTH", 0, 4) = '2015';
