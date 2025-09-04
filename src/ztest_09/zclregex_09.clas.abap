CLASS zclregex_09 DEFINITION
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
ENDCLASS.



CLASS zclregex_09 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA imported_data TYPE REF TO lcl_import_data.
    imported_data = NEW #(  ).
    imported_data->separate_string(  ).

    TRY.
       protocol_failure( company = 'some company' error_source = 'email' error_text = 'e?mail@mail..de' ).
      CATCH zcx_services_for_customers_03 INTO DATA(ex_text).
        out->write( ex_text->get_text(  ) ).
    ENDTRY.


  out->write( imported_data->get_lt_sep_strings(  ) ).
  out->write( imported_data->get_counter(  ) ).
  ENDMETHOD.


  METHOD protocol_failure.
*  DELETE from zcs03_err_prot.
*    ls_err_prot-error_source = error_source.
*    ls_err_prot-error_text = error_text.
*    MODIFY zcs03_err_prot FROM @ls_err_prot.
*    IF error_source = 'email'.
*        raise EXCEPTION TYPE zclexc_class_03
*        EXPORTING
*        textid = zclexc_class_03=>zcx_invalid_mail03
*        email = error_text.
*    ELSEIF error_source = 'company'.
*        RAISE EXCEPTION TYPE zclexc_class_03
*        EXPORTING
*        textid = zclexc_class_03=>zcx_too_long_comp03
*        company = error_text.
*    ELSE.
*        RAISE EXCEPTION TYPE zclexc_class_03
*        EXPORTING
*        textid = zclexc_class_03=>zcx_other_error03
*        other = error_text.
*    ENDIF.


  ENDMETHOD.

ENDCLASS.
