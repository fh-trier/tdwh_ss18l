CREATE OR REPLACE VIEW "TDWH_10_04" AS
SELECT *
FROM (
  SELECT
    firstname,
    lastname,
    SUBSTR(registered, 0, 7) AS "MONTH",
    SUM(quantity) AS "QUANTPERCUST",
    RANK() OVER (PARTITION BY (SUBSTR(registered, 0, 7)) ORDER BY (SUM(quantity)) DESC) AS "RANG"
  FROM (
    SELECT
      jt.*
    FROM
      weborders w,
      JSON_TABLE(
        w.jsonord, '$' COLUMNS(
          "FIRSTNAME" VARCHAR2(30) PATH '$.firstname',
          "LASTNAME" VARCHAR2(30) PATH '$.lastname',
          "REGISTERED" VARCHAR(30) PATH '$.registered',
          NESTED PATH '$.items[*]' COLUMNS (
            "QUANTITY" VARCHAR2(30) PATH '$.quantity'
          )
        )
      ) jt
  )
  GROUP BY
    firstname,
    lastname,
    SUBSTR(registered, 0, 7)
)
WHERE rang <= 2
AND SUBSTR("MONTH", 0, 4) = '2015';
