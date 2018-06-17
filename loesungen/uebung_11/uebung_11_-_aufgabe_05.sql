SELECT x.*
FROM
  dept_xml d,
  XMLTABLE('/department' PASSING d.xmldata COLUMNS
    deptno number path 'name/@deptno',
    name varchar2(50) path 'name',
    manager varchar2(15) path 'manager' default 'none',
    city varchar2(25) path 'city'
  ) x;


-- Table of XMLType
CREATE TABLE xml_test OF XMLTYPE;

-- INSERT
INSERT INTO xml_test
  SELECT
    XMLELEMENT("department",
      XMLELEMENT(
        "name",
        XMLATTRIBUTES(d.department_id AS "deptno"),
        department_name
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