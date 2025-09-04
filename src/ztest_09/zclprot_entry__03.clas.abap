CLASS zclprot_entry__03 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.
    METHODS: protocol_failure
            IMPORTING
            company TYPE string
            error_text TYPE string
            error_source TYPE string
            RAISING zcx_services_for_customers_03.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA ls_err_prot TYPE zcs03_err_prot.
    DATA lo_badi      TYPE REF TO zbadi_add_info_cust03.
    DATA lt_error_ids TYPE zibadi_add_info_cust03=>tt_failed_addresses.
ENDCLASS.



CLASS zclprot_entry__03 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

      TRY.
        protocol_failure( company = 'Some test company' error_text = 'this@testen?try.de' error_source = 'email' ).
      CATCH zcx_services_for_customers_03 INTO DATA(ocx_protocol_fail).
        out->write( ocx_protocol_fail->get_text(  ) ).
    ENDTRY.

  ENDMETHOD.


  METHOD protocol_failure.
  " Protokollöschung für Testzwecke
  DELETE from zcs03_err_prot.
  " in Protokolltabelle noch immer company als Identifikator einfügen
    ls_err_prot-company = company.
    ls_err_prot-error_source = error_source.
    ls_err_prot-error_text = error_text.
    MODIFY zcs03_err_prot FROM @ls_err_prot.

    " Raising appropriate exception with appropriate text
    IF error_source = 'email'.
        raise EXCEPTION TYPE zcx_services_for_customers_03
        EXPORTING
        textid = zcx_services_for_customers_03=>invalid_mail03
        error_comp = company
        error_text = error_text.
    ELSEIF error_source = 'company'.
        RAISE EXCEPTION TYPE zcx_services_for_customers_03
        EXPORTING
        textid = zcx_services_for_customers_03=>too_long_comp03
        error_text = error_text.
    ELSE.
        RAISE EXCEPTION TYPE zcx_services_for_customers_03
        EXPORTING
        textid = zcx_services_for_customers_03=>other_error03
        error_comp = company
        error_text = error_text.
    ENDIF.

*    GET BADI lo_badi.
*
*    CALL BADI lo_badi->get_address_info
*      EXPORTING
*        it_addresses  =
*        new_add_count =
*      .

  ENDMETHOD.
ENDCLASS.
