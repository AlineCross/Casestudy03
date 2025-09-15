CLASS lsc_zr_cs03_customers000 DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    TYPES typ_numc6 TYPE n LENGTH 6.

    METHODS adjust_numbers REDEFINITION.

ENDCLASS.

CLASS lsc_zr_cs03_customers000 IMPLEMENTATION.

  METHOD adjust_numbers.

    CHECK lines(  mapped-zrcs03customers000 ) > 0.

    LOOP AT mapped-zrcs03customers000  ASSIGNING FIELD-SYMBOL(<ls_customers>).

      <ls_customers>-CustomerID = CONV typ_numc6( zcl_services_for_customers_03=>get_next_number( iv_object = 'Z03NROBJ_C'  ) ).

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.

CLASS lhc_zr_cs03_customers000 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
*    DATA customers_upd TYPE TABLE FOR UPDATE zr_cs03_customers000.

    METHODS
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR ZrCs03Customers000
        RESULT result.

    METHODS getCity FOR DETERMINE ON SAVE
      IMPORTING keys FOR ZrCs03Customers000~getCity.

    METHODS SetSalesVolume FOR DETERMINE ON SAVE
      IMPORTING keys FOR ZrCs03Customers000~SetSalesVolume.

    METHODS check_email
      FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZrCs03Customers000~check_email.
*      getCustomerID FOR DETERMINE ON SAVE
*        IMPORTING keys FOR ZrCs03Customers000~getCustomerID.

    METHODS ShowStatistic FOR MODIFY IMPORTING keys FOR ACTION ZrCs03Customers000~ShowStatistic RESULT result.

ENDCLASS.

CLASS lhc_zr_cs03_customers000 IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

**********************************************************************
*   Ermittlung der Stadt anhand der Postleitzahl

  METHOD getCity.
    DATA lt_customers_upd TYPE TABLE FOR UPDATE zr_cs03_customers000.

    READ ENTITIES OF zr_cs03_customers000 IN LOCAL MODE
    ENTITY ZrCs03Customers000
    FIELDS ( Postcode City ) WITH CORRESPONDING #( keys )
    RESULT DATA(lt_customers).

    LOOP AT lt_customers INTO DATA(ls_customer).

      IF ls_customer-Postcode IS NOT INITIAL.

        SELECT SINGLE city
          FROM zcs03_postcode
          WHERE postcode = @ls_customer-Postcode
          INTO @DATA(lv_city).

        IF sy-subrc = 0.
          ls_customer-City = lv_city.
        ENDIF.
      ENDIF.

      MODIFY lt_customers FROM ls_customer.

    ENDLOOP.

    lt_customers_upd = CORRESPONDING #( lt_customers ).

    MODIFY ENTITIES OF zr_cs03_customers000 IN LOCAL MODE
    ENTITY ZrCs03Customers000
    UPDATE FIELDS ( City ) WITH lt_customers_upd
    REPORTED DATA(lt_reported_customers).

  ENDMETHOD.

**********************************************************************

*    Überprüfung der E-Mail-Adresse

  METHOD check_email.
    READ ENTITIES OF zr_cs03_customers000 IN LOCAL MODE
         ENTITY ZrCs03Customers000
         FIELDS ( email )
         WITH CORRESPONDING #( keys )
         RESULT DATA(lt_customers).

    LOOP AT lt_customers INTO DATA(ls_cust).
      DATA(lv_ok) = zcl_services_for_customers_03=>check_email(
                      iv_email =    ls_cust-email  ).
      IF lv_ok = abap_false.
        APPEND VALUE #(
      %key = ls_cust-%key
     %msg = new_message_with_text(
                 text     = |Ungültige E-Mail-Adresse: { ls_cust-email }|
                 severity = if_abap_behv_message=>severity-error ) )
      TO reported-zrcs03customers000.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.


*  METHOD getCustomerID.
*
*    READ ENTITIES OF zr_cs03_customers000 IN LOCAL MODE
*    ENTITY ZrCs03Customers000
*    FIELDS ( CustomerID ) WITH CORRESPONDING #( keys )
*    RESULT DATA(customers).
*
*    LOOP AT customers INTO DATA(customer).
*
*      customer-CustomerID = CONV typ_numc6( zcl_services_for_customers_03=>get_next_number( iv_object = 'Z03NROBJ_C'  ) ).
*      MODIFY customers FROM customer.
*
*    ENDLOOP.
*
*    customers_upd = CORRESPONDING #( customers ).
*
*    MODIFY ENTITIES OF zr_cs03_customers000 IN LOCAL MODE
*    ENTITY ZrCs03Customers000
*    UPDATE FIELDS ( CustomerID ) WITH customers_upd
*    REPORTED DATA(lt_reported_customers).
*
*  ENDMETHOD.


**********************************************************************

*   Berechnung der Umsätze aller Bestellungen in der Zielwährung

  METHOD SetSalesVolume.
    DATA volumerate_upd TYPE TABLE FOR UPDATE zr_cs03_customers000.
    READ ENTITIES OF zr_cs03_customers000 IN LOCAL MODE ENTITY
    ZrCs03Customers000 FIELDS (  Currency CurrencyTarget SalesVolume SalesVolumeTarget ChangeRateDate )
    WITH CORRESPONDING #( keys )
    RESULT DATA(customers).

    LOOP AT customers INTO DATA(customer).

      IF customer-ChangeRateDate IS INITIAL.
        customer-ChangeRateDate = cl_abap_context_info=>get_system_date( ).
      ENDIF.

      IF customer-CurrencyTarget IS INITIAL.
        customer-CurrencyTarget = 'USD'.
      ENDIF.

      IF customer-Currency IS INITIAL OR customer-Currency = '0'.
        customer-Currency = 'EUR'.
      ENDIF.

      TRY.
          SELECT SINGLE FROM zr_cs03_cust_conv_sales( pa_currency_target = @customer-CurrencyTarget,
          pa_customer_id = @customer-CustomerID,
          pa_date = @customer-ChangeRateDate, pa_currency = @customer-Currency )
          FIELDS SalesVolumeTarget, SalesVolume
          INTO ( @customer-SalesVolumeTarget, @customer-SalesVolume ).
          MODIFY customers FROM customer.
        CATCH cx_sy_itab_line_not_found.
        CATCH cx_root INTO DATA(ocx_root).
      ENDTRY.


    ENDLOOP.
    volumerate_upd = CORRESPONDING #( customers ).

    MODIFY ENTITIES OF zr_cs03_customers000 IN LOCAL MODE
        ENTITY ZrCs03Customers000
        UPDATE FIELDS ( SalesVolumeTarget SalesVolume ChangeRateDate Currency CurrencyTarget )
        WITH volumerate_upd.

  ENDMETHOD.

**********************************************************************

*   Statistik anzeigen inkl. Aufruf der Methoden der Statistik-Klasse und Fehlerbehandlung

  METHOD showstatistic.

    DATA lv_avg TYPE ztotalsum03.
    DATA lv_max TYPE ztotalsum03.
    DATA lv_day TYPE ztotalsum03.


*    DATA(lv_fiscal_year) = substring( val = cl_abap_context_info=>get_system_date( ) off =  0 len = 4 ).

*    DATA(lo_stats) = NEW zcl_statistics03( ).

*    DATA lo_statistic      TYPE REF TO object.

    DATA lo_statistic TYPE REF TO zif_statistics03. "reference auf interface

    DATA lv_class_name     TYPE string.
    DATA lv_interface_name TYPE string.


*    DATA lo_interface_description TYPE REF TO cl_abap_intfdescr.
*    DATA lo_object_description TYPE REF TO cl_abap_objectdescr.

    SELECT * FROM zcs03_statistic
    WHERE active = @abap_true
    INTO TABLE @DATA(lt_obj_statistics).

    TRY.
        DATA(ls_obj_statistics) = lt_obj_statistics[ 1 ].
        lv_class_name = ls_obj_statistics-class.
        lv_interface_name =  ls_obj_statistics-interface.
      CATCH cx_sy_itab_line_not_found.

        APPEND VALUE #(
        %msg = new_message_with_text(
        text = |Keine active Klasse mit dem entsprechenden Interface gefunden|
        severity = if_abap_behv_message=>severity-error ) )
        TO reported-zrcs03customers000.
        RETURN.
    ENDTRY.


*       DATA(lo_interface_description) ?= cl_abap_typedescr=>describe_by_name( lv_interface_name ).

*        IF lo_interface_description IS NOT INSTANCE OF cl_abap_intfdescr.
*          RETURN.
*        ENDIF.
*
*    IF lo_interface_description->applies_to_class( lv_class_name ) = abap_false.
*      APPEND VALUE #(
*      %msg = new_message_with_text( text = |Keine Interface gefunden|
*      severity = if_abap_behv_message=>severity-error ) )
*      TO reported-zrcs03customers000.
*      RETURN.
*    ENDIF.
*    TRY.
*        DATA lo_class_description TYPE REF TO cl_abap_classdescr.
**        DATA lo_class_type        TYPE REF TO cl_abap_typedescr.
*        DATA lo_object_description TYPE REF TO cl_abap_objectdescr.
*
*        DATA(lo_class_type) = cl_abap_typedescr=>describe_by_name( lv_class_name ).
*        IF lo_class_type IS INSTANCE OF cl_abap_typedescr.
*          lo_object_description = CAST #( lo_class_type ).
*        ENDIF.
*        IF lo_object_description IS INSTANCE OF cl_abap_objectdescr.
*          lo_class_description = CAST #( lo_object_description ).
*        ENDIF.
*      CATCH cx_root INTO DATA(ocx_root).
*        APPEND VALUE #(
*        %msg = new_message_with_text( text = |class description konnte nicht erstellt werden|
*        severity = if_abap_behv_message=>severity-error ) )
*        TO reported-zrcs03customers000.
*
*    ENDTRY.
    TRY.

* DATA lo_class_description TYPE REF TO cl_abap_classdescr.
* DATA(lo_class_description) = cl_abap_typedescr=>describe_by_name( lv_class_name ).

 DATA(lo_class_description) = CAST cl_abap_classdescr( cl_abap_classdescr=>describe_by_name( lv_class_name ) ).


      CATCH cx_sy_move_cast_error.
        APPEND VALUE #(
        %msg = new_message_with_text( text = |Casting Fehler|
        severity = if_abap_behv_message=>severity-error ) )
        TO reported-zrcs03customers000.
        RETURN.
    ENDTRY.

    IF lo_class_description IS NOT INSTANCE OF cl_abap_classdescr.

      APPEND VALUE #(
      %msg = new_message_with_text( text = |Keine Klasse gefunden|
      severity = if_abap_behv_message=>severity-error ) )
      TO reported-zrcs03customers000.
      RETURN.

    ENDIF.

    DATA(lt_interfaces) = lo_class_description->interfaces.

    IF NOT line_exists( lt_interfaces[ name = lv_interface_name ] ).

      APPEND VALUE #(
      %msg = new_message_with_text( text = |Keine Interface gefunden|
      severity = if_abap_behv_message=>severity-error ) )
      TO reported-zrcs03customers000.
      RETURN.

    ENDIF.


    TRY.
        CREATE OBJECT lo_statistic TYPE (lv_class_name).

      CATCH cx_sy_create_object_error.

        APPEND VALUE #(
        %msg = new_message_with_text( text = |Klassen Instanzzierung nicht erfolgt|
        severity = if_abap_behv_message=>severity-error ) )
        TO reported-zrcs03customers000.
        RETURN.

    ENDTRY.


*    DATA(lv_method_name01) = lt_methods[ 1 ]-name. "|avarage_sales|.
*    DATA(lv_method_name02) = lt_methods[ 2 ]-name. "|day_sales|.
*    DATA(lv_method_name03) = lt_methods[ 3 ]-name. "|max_sales|.


    SELECT SINGLE value FROM zcs03_settings
    WHERE active = @abap_true
    AND param = 'FISKAL_YEAR'
    INTO  @DATA(lv_value).

    DATA lv_fiscal_year TYPE C LENGTH 4.

    lv_fiscal_year = substring( val = lv_value off = 0 len = 4 ).

    IF lv_fiscal_year IS INITIAL.

      APPEND VALUE #(
      %msg = new_message_with_text( text = |Geschäftsjahr nicht in Settings gefunden|
      severity = if_abap_behv_message=>severity-error ) )
      TO reported-zrcs03customers000.
      RETURN.

    ENDIF.

    LOOP AT keys INTO DATA(ls_key).

      lv_avg = lo_statistic->average_sales( iv_customer_id = ls_key-CustomerID
                                            iv_fiscal_year = lv_fiscal_year ).

      lv_max = lo_statistic->max_sales( iv_customer_id = ls_key-CustomerID ).

      lv_day = lo_statistic->day_sales( iv_customer_id = ls_key-CustomerID
                                        iv_fiscal_year = lv_fiscal_year ).

*DATA(lv_msg2) = |Customer ID: { ls_key-CustomerID }{ cl_abap_char_utilities=>newline }|
*            && |Average:     { lv_avg }{ cl_abap_char_utilities=>newline }|
*            && |Max:         { lv_max }{ cl_abap_char_utilities=>newline }|
*            && |Days:        { lv_day }|.

      DATA(lv_msg) = |id: { ls_key-CustomerID } Avg: { lv_avg }  Max: { lv_max }  Day: { lv_day } |.

      APPEND VALUE #( %key = ls_key-CustomerID
                      %msg = new_message_with_text(      text = lv_msg
                                                     severity = if_abap_behv_message=>severity-information
                                                  )
                    )
      TO reported-zrcs03customers000.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
