-- VIEW
-- Wenn anstatt einer Tabelle eine View
-- genutzt wird, erspart man sich so einen
-- Trigger, der die Tabelle REPORT_52
-- aktualisiert, wenn ein neuer Datensatz
-- in der Tabelle FACTS geschrieben wird.
CREATE OR REPLACE VIEW "REPORT_52" AS
  SELECT
    dd.yearnumber,
    dd.quarter,
    CONCAT(de.emp_firstname, CONCAT(', ', de.emp_lastname)) AS "EMPLOYEE",
    dp.subcategory_name,
    SUM(f.quantity) AS "ABSATZ"
  FROM facts f
    INNER JOIN dim_date dd ON (dd.id = f.date_id)
    INNER JOIN dim_employee de ON (de.id = f.emp_id)
    INNER JOIN dim_product dp ON (dp.id = f.prod_id)
  GROUP BY
    dd.yearnumber,
    dd.quarter,
    de.emp_firstname,
    de.emp_lastname,
    dp.subcategory_name;

-- SELECT
SELECT *
FROM report_52
ORDER BY yearnumber, quarter, employee, subcategory_name;

-- TRIGGER
-- Falls anstatt von einer View eine Tabelle
-- genutzt wird, muss der folgende Trigger
-- implementiert werden.
CREATE OR REPLACE TRIGGER "REPORT_52_TRG"
AFTER INSERT ON "FACTS"
FOR EACH ROW
DECLARE
  vYear PLS_INTEGER;
  vQuarter PLS_INTEGER;
  vEmployee VARCHAR2(100);
  vSubCat VARCHAR2(50);
  vTmp PLS_INTEGER;
BEGIN
  SELECT yearnumber, quarter
  INTO vYear, vQuarter
  FROM dim_date
  WHERE id = :new.date_id;

  SELECT emp_lastname || ', ' || emp_firstname
  INTO vEmployee
  FROM dim_employee
  WHERE id = :new.emp_id;

  SELECT subcategory_name
  INTO vSubCat
  FROM dim_product
  WHERE id = :new.prod_id;

  SELECT COUNT(*)
  INTO vTmp
  FROM report_52
  WHERE yearnumber = vYear
  AND quarter = vQuarter
  AND employee = vEmployee
  AND subcategory = vSubCat;

  IF vTmp > 0 THEN
    UPDATE report_52
    SET sales = sales + :new.quantity
    WHERE yearnumber = vYear
    AND quarter = vQuarter
    AND employee = vEmployee
    AND subcategory = vSubCat;
  ELSE
    INSERT INTO report_52
    VALUES (
      vYear, vQuarter, vEmployee, vSubCat, :new.quantity
    );
  END IF;
END;
/