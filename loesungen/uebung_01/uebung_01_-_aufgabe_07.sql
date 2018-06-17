CREATE OR REPLACE PROCEDURE procGehege
AS
  v_loewe pls_integer := 0;
BEGIN
  FOR rec_i IN (SELECT gehegenr, standort FROM gehege ORDER BY gehegenr)
  LOOP
    SELECT COUNT(*) INTO v_loewe
    FROM gehegetiere a
      INNER JOIN tiere b ON (a.tiernr = b.tiernr)
    WHERE b.spezies = 'Loewe'
    AND a.gehegenr = rec_i.gehegenr;

    IF v_loewe > 0 THEN
      DBMS_OUTPUT.PUT_LINE('Gehegenr: ' || rec_i.gehegenr || '  Standort: ' || rec_i.standort || '  Achtung!');
    ELSE
      DBMS_OUTPUT.PUT_LINE('Gehegenr: ' || rec_i.gehegenr || '  Standort: ' || rec_i.standort);
    END IF;
  END LOOP;
EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20000, 'Error in procGehege!')
END;
/