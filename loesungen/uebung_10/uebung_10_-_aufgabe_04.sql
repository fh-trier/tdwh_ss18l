SELECT 
  CONCAT(firstname, CONCAT(' ', lastname)) AS "NAME",
  "MONTH",
  "RANG"
FROM (
  SELECT 
    jt.firstname, 
    jt.lastname,
    SUBSTR(jt.registered,0,7) AS "MONTH",
    RANK() OVER(PARTITION BY SUBSTR(jt.registered,0,7) ORDER BY SUM(jt.quantity) DESC) AS "RANG"
  FROM 
    weborders, 
    JSON_TABLE(jsonord, '$' COLUMNS
      firstname VARCHAR2(30) PATH '$.firstname',
      lastname VARCHAR2(30) PATH '$.lastname',
      registered VARCHAR2(30) PATH '$.registered',
      NESTED PATH '$.items[*]' COLUMNS (
        quantity VARCHAR2(30) PATH '$.quantity'
      )
    ) jt
  WHERE SUBSTR(jt.registered,0,4) = '2015'
  GROUP BY jt.firstname, jt.lastname, SUBSTR(jt.registered,0,7)
)
WHERE "RANG" <= 2
ORDER BY "MONTH";
