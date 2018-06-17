ALTER TABLE Adressen
ADD CONSTRAINT "FK_ADRESSEN_ORTE"
  FOREIGN KEY (Ortnr)
  REFERENCES Orte(Ortnr)
  ON DELETE CASCADE;

ALTER TABLE Mitarbeiter
ADD CONSTRAINT "FK_MITARBEITER_ADRESSEN"
  FOREIGN KEY (Adressnr)
  REFERENCES Adressen(Adressnr)
  ON DELETE SET NULL;