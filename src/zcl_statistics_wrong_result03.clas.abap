CLASS zcl_statistics_wrong_result03 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_statistics03.
    ALIASES avarage_sales for zif_statistics03~average_sales.
    ALIASES max_sales for zif_statistics03~max_sales.
    ALIASES day_sales for zif_statistics03~day_sales.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_statistics_wrong_result03 IMPLEMENTATION.

  METHOD zif_statistics03~average_sales.

     rv_avg_sales = '-999999.99'.

  ENDMETHOD.

  METHOD zif_statistics03~max_sales.

     rv_max_sales = '-88888888.88'.

  ENDMETHOD.

  METHOD zif_statistics03~day_sales.


    rv_day_sales = '-7.77'.

  ENDMETHOD.


ENDCLASS.
