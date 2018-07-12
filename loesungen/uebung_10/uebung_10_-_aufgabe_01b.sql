CREATE OR REPLACE VIEW "TDWH_10_01B" AS
SELECT
  jt.*
FROM
  weborders w,
  JSON_TABLE(w.jsonord, '$' COLUMNS(
      "FIRST" VARCHAR2(30) PATH '$.firstname',
      "LAST" VARCHAR2(30) PATH '$.lastname',
      "GENDER" VARCHAR2(30) PATH '$.gender',
      "PHONE" VARCHAR(30) PATH '$.phone',
      "REGISTERED" VARCHAR(30) PATH '$.registered'
    )
  ) jt
WHERE SUBSTR(jt.registered, 0, 4) = '2014';
