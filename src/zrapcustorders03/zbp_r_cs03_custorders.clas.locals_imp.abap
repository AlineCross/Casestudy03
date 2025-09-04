CLASS lsc_zr_cs03_custorders DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

  TYPES typ_numc6 TYPE n LENGTH 6.

    METHODS adjust_numbers REDEFINITION.

ENDCLASS.

CLASS lsc_zr_cs03_custorders IMPLEMENTATION.

  METHOD adjust_numbers.

    CHECK lines( mapped-zrcs03custorders ) > 0.

    LOOP AT mapped-zrcs03custorders ASSIGNING FIELD-SYMBOL(<ls_custorders>).
        TRY.
        <ls_custorders>-OrderID = CONV typ_numc6( zcl_services_for_customers_03=>get_next_number( iv_object = 'Z03NROBJ_O' ) ).
        CATCH cx_root INTO data(cxo_number_error).
        ENDTRY.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.

CLASS LHC_ZR_CS03_CUSTORDERS DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR ZrCs03Custorders
        RESULT result.
ENDCLASS.

CLASS LHC_ZR_CS03_CUSTORDERS IMPLEMENTATION.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.
ENDCLASS.
