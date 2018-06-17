SELECT DISTINCT a.mitarbeiternr, a.nachname
FROM mitarbeiter a
  INNER JOIN gehegemitarbeiter b ON (a.mitarbeiternr = b.mitarbeiternr)
  INNER JOIN gehegetiere c ON (b.gehegenr = c.gehegenr)
  INNER JOIN tiere d ON (c.tiernr = d.tiernr)
  INNER JOIN futter e ON (d.futtertyp = e.futtertyp)
WHERE e.bezeichnung = 'Obst, Pflanzen';