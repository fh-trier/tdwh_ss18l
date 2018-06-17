SELECT
  DISTINCT a.gehegenr,
  NVL(c.spezies, '-') AS Spezies
FROM gehege a
  LEFT JOIN gehegetiere b ON (a.gehegenr = b.gehegenr)
  LEFT JOIN tiere c ON (b.tiernr = c.tiernr);