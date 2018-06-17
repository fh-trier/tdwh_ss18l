SELECT 
  jt.*
FROM 
  weborders, 
  JSON_TABLE(jsonord, '$' COLUMNS
    "FIRST" VARCHAR2(30) PATH '$.firstname',
    "LAST" VARCHAR2(30) PATH '$.lastname',
    "GEND" VARCHAR2(30) PATH '$.gender',
    "PHONE" VARCHAR2(30) PATH '$.phone',
    "REGISTERED" VARCHAR2(30) PATH '$.registered'
  ) jt
WHERE SUBSTR("REGISTERED", 0, 4) = '2014';

