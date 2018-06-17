-- Serveroutput
SET serveroutput ON

-- Prozedur
CREATE OR REPLACE PROCEDURE getLocations
AS
  TYPE typeLocationsNestedTable IS TABLE OF locations%ROWTYPE;
  TYPE typeLocationsVarray IS VARRAY(12) OF NUMBER;
  --TYPE typeLocationsAarray IS TABLE OF location

  listLocationsNestedTable typeLocationsNestedTable := typeLocationsNestedTable();
  listLocationsVarray typeLocationsVarray := typeLocationsVarray();
  --listLocationsAarray typeLocationsAarray := typeLocationsAarray();

  vLoopIndex PLS_INTEGER := 1;
BEGIN

  -- NestedTable füllen
  DBMS_OUTPUT.PUT_LINE('NestedTable');
  DBMS_OUTPUT.PUT_LINE('ID' || CHR(9) ||
                       'Street-Address' || CHR(9) ||
                       'Postal-Code' || CHR(9) ||
                       'City' || CHR(9) ||
                       'State-Province' || CHR(9) ||
                       'Country-ID');
  FOR recLocations IN (SELECT * FROM locations) LOOP
    listLocationsNestedTable.EXTEND;
    listLocationsNestedTable(vLoopIndex) := recLocations;
    DBMS_OUTPUT.PUT_LINE(recLocations.location_id || CHR(9) || recLocations.street_address || CHR(9) || recLocations.postal_code || CHR(9) || recLocations.CITY || CHR(9) || recLocations.STATE_PROVINCE || CHR(9) || recLocations.country_id);
    vLoopIndex:= vLoopIndex + 1;
  END LOOP;


  -- vArray befüllen
  vLoopIndex := 1;
  DBMS_OUTPUT.PUT_LINE('VArray');
  DBMS_OUTPUT.PUT_LINE('ID');
  FOR recLocationId IN (SELECT location_id FROM locations ORDER BY location_id) LOOP
    IF vLoopIndex < 13 THEN
      listLocationsVarray.EXTEND;
      DBMS_OUTPUT.PUT_LINE(recLocationId.location_id);
      listLocationsVarray(vLoopIndex) := recLocationId.location_id;
      vLoopIndex := vLoopIndex + 1;
    END IF;
  END LOOP;

END;

/

EXEC getLocations();