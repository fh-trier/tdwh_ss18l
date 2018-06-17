CREATE OR REPLACE TRIGGER "GEHEGE_TIERE_I"
BEFORE INSERT ON TIERE
FOR EACH ROW
DECLARE
  v_cur NUMBER;
  v_max Gehege.maxTiere%TYPE;
BEGIN
  SELECT maxTiere INTO v_max
  FROM Gehege
  WHERE Gehegenr = :NEW:Gehegenr;

  SELECT COUNT(*)
  FROM GehegeTrier
  WHERE GehegeTiere = :NEW:Gehegenr;

  IF v_max =< v_cur THEN
    RAISE_APPLICATION_ERROR(20001, 'Das Gehege ist voll!');
  END IF;

END;
/