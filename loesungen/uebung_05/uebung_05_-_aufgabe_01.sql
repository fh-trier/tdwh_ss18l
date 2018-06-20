--------------------------------------------------------
--                       DIMS                         --
--------------------------------------------------------

-- Clean
DROP TABLE "DIM_CUSTOMER";
DROP SEQUENCE "DIM_CUSTOMER_SEQ";

-- DIM_CUSTOMER
CREATE TABLE "DIM_CUSTOMER" (
  "ID" NUMBER,
  "CUST_ID" NUMBER(6,0),
  "CUST_FIRSTNAME" VARCHAR2(20 BYTE),
  "CUST_LASTNAME" VARCHAR2(20 BYTE),
  "CUST_PHONE" VARCHAR2(50 BYTE),
  "CUST_NLS_LANGUAGE" VARCHAR2(3 BYTE),
  "CUST_NLS_TERRITORY" VARCHAR2(30 BYTE),
  "CUST_CREDIT_LIMIT" NUMBER(9,2),
  "CUST_EMAIL" VARCHAR2(40 BYTE),
  "CUST_ACCOUNT_MANAGER_ID" NUMBER(6,0),
  "CUST_GEO_LOCATION" NUMBER(38,0),
  "CUST_DATE_OF_BIRTH" DATE,
  "CUST_MARITAL_STATUS" VARCHAR2(20 BYTE),
  "CUST_GENDER" VARCHAR2(1 BYTE),
  "CUST_INCOME_LEVEL" VARCHAR2(20 BYTE),
  "CUST_ADDRESS" VARCHAR2(60 BYTE),
  "COUNTRY_ID" CHAR(2 BYTE),
  "COUNTRY_NAME" VARCHAR2(40 BYTE),
  "REGION_ID" NUMBER,
  "REGION_NAME" VARCHAR2(25 BYTE),
  CONSTRAINT "DIM_CUSTOMER_PK" PRIMARY KEY ("ID")
);

-- SEQUENCE
CREATE SEQUENCE "DIM_CUSTOMER_SEQ"
START WITH 1
NOCACHE
ORDER;

-- Trigger
CREATE OR REPLACE TRIGGER "DIM_CUSTOMER_ID_TRG"
BEFORE INSERT OR UPDATE OF "ID" ON "DIM_CUSTOMER"
FOR EACH ROW
DECLARE

BEGIN
  IF UPDATING('ID') THEN
    RAISE_APPLICATION_ERROR(-20001, 'ID darf nicht verändert werden!');
  END IF;

  IF INSERTING THEN
    :NEW.ID := DIM_CUSTOMER_SEQ.NEXTVAL;
  END IF;
END;
/

-- Dummy Value
INSERT INTO "DIM_CUSTOMER"
VALUES (0, -1, 'unbekannt', 'unbekannt', 'unbekannt', '-', 'unbekannt', 0, 'unbekannt', 0, 0, TO_DATE('01.01.1900', 'dd.mm.yyyy'), 'unbekannt', '-', 'unbekannt', 'unbekannt', 0, 'unbekannt', 0, 'unbekannt');

INSERT INTO "DIM_CUSTOMER"
SELECT
  null,   -- DIM_ID
  -- Customer
  cu.customer_id, cu.cust_first_name,
  cu.cust_last_name, cu.phone_number,
  cu.nls_language, cu.nls_territory,
  cu.credit_limit, cu.cust_email,
  cu.account_mgr_id, cu.cust_geo_location,
  cu.date_of_birth, cu.marital_status,
  cu.gender, cu.income_level,
  cu.cust_address,
-- Country
  co.country_id, co.country_name,
-- Region
  re.region_id, re.region_name
FROM customers cu
  LEFT JOIN countries co ON (cu.country_id = co.country_id)
  LEFT JOIN regions re ON (co.region_id = re.region_id);

COMMIT;


--------------------------------------------------------
--                      FACTS                         --
--------------------------------------------------------
DROP TABLE "FACTS" CASCADE CONSTRAINTS PURGE;

CREATE TABLE "FACTS" (
  "DATE_ID" NUMBER,
  "TIME_ID" NUMBER,
  "PROD_ID" NUMBER,
  "CUST_ID" NUMBER,
  "EMP_ID" NUMBER,
  "CHANNEL_ID" NUMBER,
  "PROM_ID" NUMBER,
  "QUANTITY" NUMBER(8,0),
  "UNIT_PRICE" NUMBER(8,2),
  CONSTRAINT "FACTS_PK" PRIMARY KEY(
    "DATE_ID", "TIME_ID",
    "PROD_ID", "CUST_ID",
    "EMP_ID", "CHANNEL_ID",
    "PROM_ID"
  ),
  CONSTRAINT "FACTS_DATE_FK" FOREIGN KEY ("DATE_ID")
    REFERENCES "DIM_DATE" ("ID"),
  CONSTRAINT "FACTS_TIME_FK" FOREIGN KEY ("TIME_ID")
    REFERENCES "DIM_TIME" ("ID"),
  CONSTRAINT "FACTS_PROD_FK" FOREIGN KEY ("PROD_ID")
    REFERENCES "DIM_PRODUCT" ("ID"),
  CONSTRAINT "FACTS_CUST_FK" FOREIGN KEY ("CUST_ID")
     REFERENCES "DIM_CUSTOMER" ("ID"),
  CONSTRAINT "FACTS_EMP_FK" FOREIGN KEY ("EMP_ID")
    REFERENCES "DIM_EMPLOYEE" ("ID"),
  CONSTRAINT "FACTS_CHANNEL_FK" FOREIGN KEY ("CHANNEL_ID")
    REFERENCES "DIM_CHANNEL" ("ID"),
  CONSTRAINT "FACTS_PROM_FK" FOREIGN KEY ("PROM_ID")
    REFERENCES "DIM_PROMOTION" ("ID")
);

-- INSERT
INSERT INTO "FACTS"
SELECT
  (
    SELECT id
    FROM dim_date
    WHERE yearnumber = EXTRACT(YEAR FROM o.order_date)
    AND monthnumber = EXTRACT(MONTH FROM o.order_Date)
    AND daynumber = EXTRACT(DAY FROM o.order_Date)
  ),
  (
    SELECT id
    FROM dim_time
    WHERE hournumber = EXTRACT(HOUR FROM o.order_date)
    AND minutenumber = EXTRACT(minute from o.order_date)
  ),
  (
    SELECT id FROM dim_product WHERE product_id = NVL(oi.product_id, -1)
  ),
  (
    SELECT id FROM dim_customer WHERE cust_id = NVL(o.customer_id, -1)
  ),
  (
    SELECT id FROM dim_employee WHERE employee_id = NVL(o.sales_rep_id, -1)
  ),
  (
    SELECT id FROM dim_channel WHERE channel_id = NVL(o.channel_id,-1)
  ),
  (
    SELECT id FROM dim_promotion WHERE promo_id = NVL(o.promotion_id, -1)
  ),
  oi.quantity,
  oi.unit_price
FROM orders o
  INNER JOIN order_items oi ON (o.order_id = oi.order_id);

COMMIT;