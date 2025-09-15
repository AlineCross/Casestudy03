CLASS zcl_statistics03 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_statistics03 .
*    ALIASES avarage_sales for zif_statistics03~average_sales.
*    ALIASES max_sales for zif_statistics03~max_sales.
*    ALIASES day_sales for zif_statistics03~day_sales.

  PROTECTED SECTION.

  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_statistics03 IMPLEMENTATION.


  METHOD zif_statistics03~average_sales.

*    Implementierung der Interface-Methode average_sales zur Berechnung des durchschnittlichen Umsatzes eines Kunden

    SELECT  AVG( order_total )  FROM zcs03_custorders
    WHERE customer_id = @iv_customer_id
    AND status = 'BB'
    AND substring( order_date, 1, 4 ) = @iv_fiscal_year
    INTO @rv_avg_sales.

  ENDMETHOD.

**********************************************************************

  METHOD zif_statistics03~max_sales.

*    Implementierung der Interface-Methode max_sales zur Ermittlung des maximalen Umsatzes eines Kunden

    SELECT MAX( order_total ) FROM zcs03_custorders
    WHERE customer_id = @iv_customer_id
    AND status = 'BB'
    INTO @rv_max_sales.

  ENDMETHOD.

**********************************************************************

  METHOD zif_statistics03~day_sales.


    DATA lv_verstrichene_tage TYPE int4.

*   Ohne DATS würde 20253112 - 20250101 = 1131 ergeben!

*    DATA(lv_fiskal_date_to)   = CONV dats( |{ iv_fiscal_year }1231| ).

*    Berechnen der vergangenen tage im aktuellen Geschäftsjahr

    DATA(lv_fiskal_date_from) = CONV dats( |{ iv_fiscal_year }0101| ).
    DATA(lv_fiskal_date_to) =  CONV dats( cl_abap_context_info=>get_system_date(  ) ).
    lv_verstrichene_tage = ( lv_fiskal_date_to - lv_fiskal_date_from ) + 1. "2028 ist Schaltjahr und ist 366 Tage

*    Zusammenzählen aller bezahlten Umsätze

    SELECT  SUM( order_total )  FROM zcs03_custorders
*    WHERE customer_id = @iv_customer_id
    WHERE status = 'BB'
    AND order_date BETWEEN @lv_fiskal_date_from AND @lv_fiskal_date_to
    INTO @DATA(lv_sum_of_sales).

*    Durchschnittlichen Tagesumsatz berechnen
    IF lv_verstrichene_tage > 0.
      rv_day_sales = lv_sum_of_sales / lv_verstrichene_tage.
    ELSE.
      rv_day_sales = 0.
    ENDIF.

  ENDMETHOD.


ENDCLASS.
