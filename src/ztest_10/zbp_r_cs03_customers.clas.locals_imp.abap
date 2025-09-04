CLASS lhc_zr_cs03_customers DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    DATA customers_upd TYPE TABLE FOR UPDATE zr_cs03_customers.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR Customers
        RESULT result,

      check_email
        FOR VALIDATE ON SAVE
        IMPORTING keys FOR Customers~check_email,

      fill_city
        FOR DETERMINE ON SAVE
        IMPORTING keys FOR Customers~fill_city.
*        METHODS assign_customerid
*      FOR DETERMINE ON MODIFY
*      IMPORTING keys FOR Customers~assign_customerid.
ENDCLASS.

CLASS lhc_zr_cs03_customers IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD check_email.
    READ ENTITIES OF zr_cs03_customers IN LOCAL MODE
         ENTITY Customers
         FIELDS ( email )
         WITH CORRESPONDING #( keys )
         RESULT DATA(lt_customers).

    LOOP AT lt_customers INTO DATA(ls_cust).
      DATA(lv_ok) = zcl_services_for_customers__10=>check_email(
                      iv_email =  CONV string( ls_cust-email ) ).
      IF lv_ok = abap_false.
        APPEND VALUE #(
          %key = ls_cust-%key
          %msg = new_message_with_text(
                   text     = |Ungültige E-Mail-Adresse: { ls_cust-email }|
                   severity = if_abap_behv_message=>severity-error ) )
        TO reported-customers.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD fill_city.

    READ ENTITIES OF zr_cs03_customers IN LOCAL MODE
      ENTITY Customers
        FIELDS ( Postcode City )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_customers).

    LOOP AT lt_customers INTO DATA(ls_cust).
      IF ls_cust-Postcode IS NOT INITIAL.

        SELECT SINGLE city
          FROM zcs03_postcode
          WHERE postcode = @ls_cust-Postcode
          INTO @DATA(lv_city).

        IF sy-subrc = 0.
          ls_cust-City = lv_city.
        ENDIF.
      ENDIF.
      MODIFY lt_customers FROM ls_cust.
    ENDLOOP.

    customers_upd = CORRESPONDING #( lt_customers ).

    MODIFY ENTITIES OF zr_cs03_customers IN LOCAL MODE
    ENTITY zr_cs03_customers
    UPDATE FIELDS ( City ) WITH customers_upd.
*   REPORTED DATA(lt_reported)
*   FAILED   DATA(lt_failed).

*    reported-customers = CORRESPONDING #( lt_reported-customers ).

  ENDMETHOD.
*>>> Aymen
*  METHOD fill_city.
*    READ ENTITIES OF zr_cs03_customers IN LOCAL MODE
*      ENTITY Customers
*        FIELDS ( Postcode City )
*        WITH CORRESPONDING #( keys )
*      RESULT DATA(lt_customers).

*  LOOP AT lt_customers INTO DATA(ls_cust).
*    IF ls_cust-Postcode IS NOT INITIAL.
*
*      SELECT SINGLE city
*        FROM zcs03_postcode
*        WHERE postcode = @ls_cust-Postcode
*        INTO @DATA(lv_city).
*
*      IF sy-subrc = 0.
*        MODIFY ENTITIES OF zr_cs03_customers IN LOCAL MODE
*          ENTITY Customers
*          UPDATE FIELDS ( City )
*          WITH VALUE #( ( %key = ls_cust-%key
*                          City = lv_city ) )
*          REPORTED DATA(lt_reported)
*          FAILED   DATA(lt_failed).
*      ENDIF.
*
*    ENDIF.
*  ENDLOOP.
*ENDMETHOD.
*<<< Aymen

*  METHOD ASSIGN_CUSTOMERID.
*
*READ ENTITIES OF zr_cs03_customers IN LOCAL MODE
*      ENTITY Customers
*        FIELDS ( CustomerID )
*        WITH CORRESPONDING #( keys )
*      RESULT DATA(lt_customers).
*
*    LOOP AT lt_customers INTO DATA(ls_cust).
*      " 1. Nummer aus Nummernkreis (z. B. SNRO Objekt ZCUSTNR)
*
*       TRY.
*         cl_numberrange_runtime=>number_get(
*         exporting
*                              object       = 'ZCUSTNR'   " SNRO-Objekt
*                              nr_range_nr  = '01'        " Intervall
*                              quantity     = 1
*                              subobject    = ''
*                              ignore_buffer = abap_false
*                               IMPORTING
*        number        = DATA(lv_number) ).
*
*          " Kundennummer setzen
*          MODIFY ENTITIES OF zr_cs03_customers IN LOCAL MODE
*            ENTITY Customers
*            UPDATE FIELDS ( CustomerID )
*            WITH VALUE #( ( %key = ls_cust-%key
*                            CustomerID = |{ lv_number ALPHA = IN }| ) ).
*
*        CATCH zcx_services_for_customers_03 INTO DATA(lx_nr).
*          APPEND VALUE #( %key = ls_cust-%key
*                          %msg = new_message_with_text(
*                            text     = |Nummernvergabe fehlgeschlagen: { lx_nr->get_text( ) }|
*                            severity = if_abap_behv_message=>severity-error ) )
*            TO reported-customers.
*            ENDTRY.
*
*
*
*
*            endloop.
*  ENDMETHOD.

ENDCLASS.
