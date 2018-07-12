SELECT t.deptno
FROM tdwh_11_01 t
WHERE NOT XMLEXISTS('/department/manager' PASSING t.xmldata);
