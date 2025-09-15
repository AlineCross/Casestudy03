CLASS lsc_zr_11_custom DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.
    TYPES typ_numc6 TYPE n LENGTH 6.
    METHODS adjust_numbers REDEFINITION.

ENDCLASS.

CLASS lsc_zr_11_custom IMPLEMENTATION.

  METHOD adjust_numbers.

    CHECK lines(  mapped-zc_11_orders ) > 0.


    LOOP AT mapped-zc_11_orders ASSIGNING FIELD-SYMBOL(<ls_orders>).

      <ls_orders>-OrderId = CONV typ_numc6( zcl_services_for_customers_03=>get_next_number( iv_object = 'Z03NROBJ_O'  ) ).

    ENDLOOP.


    CHECK lines(  mapped-zr_11_custom ) > 0.

    LOOP AT mapped-zr_11_custom ASSIGNING FIELD-SYMBOL(<ls_customers>).

      <ls_customers>-Customer_ID = CONV typ_numc6( zcl_services_for_customers_03=>get_next_number( iv_object = 'Z03NROBJ_C'  ) ).

    ENDLOOP.



  ENDMETHOD.

ENDCLASS.

CLASS lhc_ZR_11_CUSTOM DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zr_11_custom RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zr_11_custom RESULT result.

ENDCLASS.

CLASS lhc_ZR_11_CUSTOM IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

ENDCLASS.
