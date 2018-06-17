SELECT gehegenr
FROM gehegetiere
GROUP BY gehegenr
HAVING COUNT(*) = (
  SELECT MAX(COUNT(*))
  FROM gehegetiere
  GROUP BY gehegenr
);