CLASS zcl_services_for_customers_03 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.

    CLASS-METHODS test_statistic.

    CLASS-METHODS create_number_range_object
      IMPORTING iv_object      TYPE znrobj03
                iv_domlen      TYPE znrlendom03
                iv_package     TYPE devclass
                iv_transport   TYPE trkorr
                iv_object_text TYPE znrobjtext03.

    CLASS-METHODS create_numberrange_intervals
      IMPORTING
        iv_rangenr TYPE zrangenr03
        iv_nrvon   TYPE znrfrom03
        iv_nrbis   TYPE znrto03
        iv_object  TYPE znrobj03.

    CLASS-METHODS delete_numberrange_intervals
      IMPORTING
        iv_rangenr TYPE zrangenr03
        iv_nrvon   TYPE znrfrom03
        iv_nrbis   TYPE znrto03
        iv_object  TYPE znrobj03.

    CLASS-METHODS read_numberrange_intervals
      IMPORTING
        iv_rangenr TYPE zrangenr03
        iv_object  TYPE znrobj03.

    CLASS-METHODS change_numberrange_intervals
      IMPORTING
        iv_rangenr TYPE zrangenr03
        iv_nrvon   TYPE znrfrom03
        iv_nrbis   TYPE znrto03
        iv_object  TYPE znrobj03.

    CLASS-METHODS get_next_number
      IMPORTING
                iv_object        TYPE znrobj03
      RETURNING VALUE(rv_number) TYPE znrovalue03.

    CLASS-METHODS delete_number_range_object
      IMPORTING iv_object TYPE znrobj03.

    CLASS-METHODS check_email
      IMPORTING iv_email             TYPE zemail03
      RETURNING VALUE(rv_email_bool) TYPE abap_bool.

    CLASS-METHODS check_company
      IMPORTING iv_company             TYPE zcompany03
      RETURNING VALUE(rv_company_bool) TYPE abap_bool.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_services_for_customers_03 IMPLEMENTATION.



  METHOD create_number_range_object.

*  Erstellen eines Nummernkreisobjektes

    TRY.
        cl_numberrange_objects=>create(
           EXPORTING
             attributes = VALUE #( object = iv_object
                                   domlen = iv_domlen
                               percentage = 10
                                 devclass = iv_package
*                                   corrnr = 'SIDK123456'
                                   )

             obj_text   = VALUE #( object     = iv_object
                                   langu      = 'D'
                                   txt        = 'Nummernkreis für customer_ID'
                                   txtshort   = 'NRKRS CUSTOMER_ID' )
         IMPORTING
           errors     = DATA(lt_errors)
           returncode = DATA(lv_returncode)
         ).
      CATCH cx_number_ranges INTO DATA(ocx).
        CLEAR ocx.
    ENDTRY.
  ENDMETHOD.

**********************************************************************

  METHOD delete_number_range_object.

*    Löschen eines Nummernkreisobjektes

    TRY.
        cl_numberrange_objects=>delete(
          object = iv_object
*       corrnr =
        ).
      CATCH cx_nr_object_not_found.
      CATCH cx_number_ranges.
    ENDTRY.
  ENDMETHOD.

**********************************************************************

  METHOD create_numberrange_intervals.
    TRY.
        cl_numberrange_intervals=>create(
          EXPORTING
            interval  = VALUE #( ( nrrangenr = iv_rangenr fromnumber = iv_nrvon tonumber = iv_nrbis procind = 'I' ) )
               object = iv_object
*           subobject = ''
*           option    =
            IMPORTING
              error     = DATA(lv_error)
              error_inf = DATA(ls_error)
              error_iv  = DATA(lt_error_iv)
              warning   = DATA(lv_warning)
        ).
      CATCH cx_nr_object_not_found.
      CATCH cx_number_ranges INTO DATA(ocx).
        CLEAR ocx.
    ENDTRY.
  ENDMETHOD.

**********************************************************************

  METHOD delete_numberrange_intervals.

*   Löschen der Intervalle eines Nummernkreisobjektes

    TRY.
        cl_numberrange_intervals=>delete(
          EXPORTING
            interval  = VALUE #( ( nrrangenr = iv_rangenr fromnumber = iv_nrvon tonumber = iv_nrbis procind = 'D' ) )
            object    = iv_object
*           subobject = ''
*    option    =
          IMPORTING
              error     = DATA(lv_error)
              error_inf = DATA(ls_error)
              error_iv  = DATA(lt_error_iv)
              warning   = DATA(lv_warning)
      ).
      CATCH cx_nr_object_not_found.
      CATCH cx_number_ranges.
    ENDTRY.
  ENDMETHOD.

**********************************************************************

  METHOD change_numberrange_intervals.

*  Ändern der Intervalle eines Nummernkreisobjektes

    TRY.
        cl_numberrange_intervals=>update(
          EXPORTING
            interval  = VALUE #( ( nrrangenr = iv_rangenr fromnumber = iv_nrvon tonumber = iv_nrbis procind = 'U' ) )
            object    = iv_object
*      subobject =
*      option    =
          IMPORTING
              error     = DATA(lv_error)
              error_inf = DATA(ls_error)
              error_iv  = DATA(lt_error_iv)
              warning   = DATA(lv_warning)
        ).
      CATCH cx_nr_object_not_found.
      CATCH cx_number_ranges.
    ENDTRY.
  ENDMETHOD.

**********************************************************************

  METHOD read_numberrange_intervals.
    TRY.
        cl_numberrange_intervals=>read(
          EXPORTING
            nr_range_nr1 = iv_rangenr
*    nr_range_nr2 =
            object       = iv_object
*    subobject    =
          IMPORTING
            interval     = DATA(lt_range_interval)
        ).
      CATCH cx_nr_object_not_found.
      CATCH cx_nr_subobject.
      CATCH cx_number_ranges.
    ENDTRY.
  ENDMETHOD.

**********************************************************************

  METHOD get_next_number.

*    Abfrage der nächsten Nummer aus dem Nummernkreisobjekt

    TRY.
        cl_numberrange_runtime=>number_get(
          EXPORTING
*    ignore_buffer     =
            nr_range_nr       = '01'
            object            = iv_object
*    quantity         =
*    subobject        =
*    toyear           =
          IMPORTING
                number        =  DATA(lv_number)
            returncode        =  DATA(lv_returncode)
            returned_quantity =  DATA(lv_return_quantity)
        ).
      CATCH cx_nr_object_not_found.
      CATCH cx_number_ranges.
    ENDTRY.

    rv_number = lv_number.

  ENDMETHOD.

**********************************************************************

  METHOD check_email.

*    Überprüfung der E-Mail-Adresse mit Regex

    IF iv_email IS INITIAL.
      rv_email_bool = abap_true.
    ELSE.
      CONSTANTS lc_regex TYPE string VALUE
*   `\A[A-Za-z0-9._+-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}\z`.
*   '^[A-Za-z0-9](?!.*\.\.)[A-Za-z0-9._\-]*@[A-Za-z0-9\-]+(\.[A-Za-z0-9\-]+)*\.[A-Za-z]{2,}$'.

   '^[A-Za-z0-9](?!.*\.\.)[A-Za-z0-9._\-]*@[A-Za-z0-9\-]+(\.[A-Za-z0-9\-]+)*\.[A-Za-z]{2,}$'.

      rv_email_bool = xsdbool( matches( val = iv_email regex = lc_regex ) ).

*  IF lv_ok = abap_false.
*    RAISE EXCEPTION TYPE zcx_services_for_customers_03
*      EXPORTING
*        textid = zcx_services_for_customers_03=>invalid_mail03
*       .
    ENDIF.
  ENDMETHOD.

**********************************************************************

  METHOD check_company.

*  Überprüfung des Firmennamens auf Länge

    rv_company_bool = abap_true.
    IF iv_company IS INITIAL.
*     RAISE EXCEPTION TYPE zcx_services_for_customers_03
*      EXPORTING
*        textid = zcx_services_for_customers_03=>other_error03
      rv_company_bool = abap_false.
    ELSEIF strlen( iv_company ) > 60.
*    RAISE EXCEPTION TYPE zcx_services_for_customers_03
*      EXPORTING
*        textid  = zcx_services_for_customers_03=>too_long_comp03
      rv_company_bool = abap_false.
    ENDIF.

  ENDMETHOD.

**********************************************************************

  METHOD test_statistic.

*    DATA lo_stats     TYPE REF TO object.
*
*    DATA lv_class_name     TYPE seoclsname.
*    DATA lv_interface_name TYPE seoclsname.
*
*    DATA lo_interface_description TYPE REF TO cl_abap_intfdescr.
*
*
*    SELECT * FROM zcs03_statistic
*    WHERE active = @abap_true
*    INTO TABLE @DATA(lt_obj_statistics).
*
*    TRY.
*        DATA(ls_obj_statistics) = lt_obj_statistics[ 1 ].
*        lv_class_name = ls_obj_statistics-class.
*        lv_interface_name =  ls_obj_statistics-interface.
*      CATCH cx_sy_itab_line_not_found.
*        EXIT.
*    ENDTRY.
*
*    lo_interface_description ?= cl_abap_intfdescr=>describe_by_name( lv_interface_name ).
*
*    IF lo_interface_description->applies_to_class( lv_class_name ) = abap_false.
*      " interface ist nicht in der Klasse implementiert
*      " RAISE EXCEPTION TYPE *****
*      EXIT.
*    ENDIF.
*
*    TRY.
*        CREATE OBJECT lo_stats TYPE (lv_class_name).
*      CATCH cx_sy_create_object_error.
*        EXIT.
*    ENDTRY.
*
*    DATA(lv_avg) = lo_stats->zif_statistics03~max_salesaverage_sales(
*                     iv_customer_id = '000208'
*                     iv_fiscal_year = '2025' ).
*
*    DATA(lv_max) = lo_stats->zif_statistics03~max_sales(
*                     iv_customer_id = '000208' ).
*
*    DATA(lv_day) = lo_stats->zif_statistics03~day_sales(
*                     iv_customer_id = '000208'
*                     iv_fiscal_year = '2025' ).

  ENDMETHOD.

ENDCLASS.
