CREATE OR REPLACE VIEW "TDWH_10_05" AS
SELECT
  jt.firstname AS "FIRSTNAME",
  jt.lastname AS "LASTNAME",
  COUNT(jt.quantity) AS "ORDERS"
FROM
  weborders w,
  JSON_TABLE(
    w.JSONORD, '$' COLUMNS (
      "FIRSTNAME" VARCHAR2(30) PATH '$.firstname',
      "LASTNAME" VARCHAR2(30) PATH '$.lastname',
      NESTED PATH '$.items[*]' COLUMNS (
        "QUANTITY" VARCHAR2(30) PATH '$.quantity'
      )
    )
  ) jt
GROUP BY
  jt.firstname,
  jt.lastname
ORDER BY
  jt.firstname,
  jt.lastname;