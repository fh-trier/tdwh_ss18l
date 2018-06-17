SELECT spezies, COUNT(*) AS Anzahl
FROM tiere
GROUP BY spezies;