INTERFACE zif_statistics03
  PUBLIC .
*  TYPES gjahr TYPE n LENGTH 4.
*  TYPES totalsumsales TYPE p LENGTH 15 DECIMALS 2.

  METHODS
    average_sales
      IMPORTING
        iv_customer_id      TYPE zcustomer_id03
        iv_fiscal_year      TYPE ZGESCHAEFTSHJAHR03
      RETURNING
        VALUE(rv_avg_sales) TYPE ztotalsum03.

  METHODS
    max_sales
      IMPORTING
        iv_customer_id      TYPE zcustomer_id03
      RETURNING
        VALUE(rv_max_sales) TYPE ztotalsum03.

  METHODS
    day_sales
      IMPORTING
        iv_customer_id      TYPE zcustomer_id03
        iv_fiscal_year      TYPE ZGESCHAEFTSHJAHR03
      RETURNING
        VALUE(rv_day_sales) TYPE ztotalsum03.


ENDINTERFACE.
