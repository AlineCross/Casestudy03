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

    METHODS getCity FOR DETERMINE ON save
      IMPORTING keys FOR ZrCs03Customers000~getCity.

    METHODS SetSalesVolume FOR DETERMINE ON SAVE
      IMPORTING keys FOR ZrCs03Customers000~SetSalesVolume.

    METHODS check_email
        FOR VALIDATE ON SAVE
        IMPORTING keys FOR ZrCs03Customers000~check_email.
*      getCustomerID FOR DETERMINE ON SAVE
*        IMPORTING keys FOR ZrCs03Customers000~getCustomerID.
ENDCLASS.

CLASS lhc_zr_cs03_customers000 IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

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

  METHOD SetSalesVolume.
  DATA volumerate_upd TYPE TABLE FOR UPDATE zr_cs03_customers000.
    READ ENTITIES OF zr_cs03_customers000 IN LOCAL MODE ENTITY
    ZrCs03Customers000 FIELDS (  Currency CurrencyTarget SalesVolume SalesVolumeTarget ChangeRateDate )
    WITH CORRESPONDING #( keys )
    RESULT DATA(customers).

    LOOP AT customers INTO DATA(customer).

    If customer-ChangeRateDate IS INITIAL.
    customer-ChangeRateDate = cl_abap_context_info=>get_system_date( ).
    ENDIF.

    IF customer-CurrencyTarget IS INITIAL.
    customer-CurrencyTarget = 'USD'.
    ENDIF.

    IF customer-Currency IS INITIAL.
    customer-Currency = 'EUR'.
    ENDIF.

        SELECT SINGLE FROM zr_cs03_cust_conv_sales( pa_currency_target = @customer-CurrencyTarget,
        pa_customer_id = @customer-CustomerID,
        pa_date = @customer-ChangeRateDate )
        FIELDS SalesVolumeTarget, SalesVolume
        INTO ( @customer-SalesVolumeTarget, @customer-SalesVolume ).
        MODIFY customers FROM customer.


    ENDLOOP.
    volumerate_upd = CORRESPONDING #( customers ).

    MODIFY ENTITIES OF zr_cs03_customers000 IN LOCAL MODE
        ENTITY ZrCs03Customers000
        UPDATE FIELDS ( SalesVolumeTarget SalesVolume ChangeRateDate )
        WITH volumerate_upd.

  ENDMETHOD.



ENDCLASS.
