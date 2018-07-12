SELECT
  XMLQUERY('for $i in /department
             where $i/city = "Toronto"
             return ($i/name, $i/city)'
             PASSING t.xmldata RETURNING CONTENT)
FROM  tdwh_11_01 t