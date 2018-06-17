SELECT
FROM mitarbeiter
WHERE mitarbeiternr NOT IN (
  SELECT mitarbeiternr
  FROM gehegemitarbeiter
);