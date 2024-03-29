CREATE OR REPLACE VIEW "TDWH_10_01A" AS
SELECT
  JSON_VALUE(w.jsonord, '$.firstname') AS "FIRST",
  JSON_VALUE(w.jsonord, '$.lastname') AS "LAST",
  JSON_VALUE(w.jsonord, '$.gender') AS "GENDER",
  JSON_VALUE(w.jsonord, '$.phone') AS "PHONE"
FROM weborders w
WHERE SUBSTR(JSON_VALUE(w.jsonord, '$.registered'), 0, 4) = '2014';