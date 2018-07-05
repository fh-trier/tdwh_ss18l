CREATE OR REPLACE VIEW "TDWH_11_05A" AS
SELECT x.*
FROM
  tdwh_11_01 t,
  XMLTABLE('/department' PASSING t.xmldata COLUMNS
    "DEPT_NO" NUMBER PATH 'name/@deptno',
    "DEPT_NAME" VARCHAR2(50) PATH 'name',
    "MANAGER" VARCHAR2(15) PATH 'manager' DEFAULT 'none',
    "CITY" VARCHAR2(25) PATH 'city'
  ) x;


-- Table of XMLType
CREATE TABLE "TDWH_11_05B" OF XMLTYPE;

-- INSERT
INSERT INTO "TDWH_11_05B"
  SELECT
    XMLELEMENT("department",
      XMLELEMENT(
        "name",
        XMLATTRIBUTES(d.department_id AS "deptno"),
        d.department_name
      ),
      XMLFOREST(
        e.last_name AS "manager",
        l.city AS "city"
      )
    )
  FROM departments d
    INNER JOIN locations l ON (d.location_id = l.location_id)
    LEFT JOIN employees e ON d.manager_id = e.employee_id;

-- COMMIT
COMMIT;