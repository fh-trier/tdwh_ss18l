DROP TABLE orders_ext;

CREATE TABLE orders_ext (
  order_id NUMBER(8),
  order_date DATE,
  channel_id NUMBER(8),
  customer_id NUMBER(8),
  order_status NUMBER(2),
  sales_rep_id NUMBER(4),
  product_id NUMBER(4),
  line_item_id NUMBER(2),
  quantity NUMBER(3) )
ORGANIZATION EXTERNAL
(
  DEFAULT DIRECTORY student_dir
  ACCESS PARAMETERS (
    RECORDS DELIMITED BY newline
    NOBADFILE NOLOGFILE NODISCARDFILE
    FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"'
    MISSING FIELD VALUES ARE NULL (
      order_id,
      order_date DATE 'DD.MM.YYYY HH24:MI:SS',
      channel_id,
      customer_id,
      order_status,
      sales_rep_id,
      product_id,
      line_item_id,
      quantity
    )
  )
  LOCATION ('orders.csv')
)
REJECT LIMIT UNLIMITED;