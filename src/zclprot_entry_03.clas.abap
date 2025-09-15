CLASS zclprot_entry_03 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
*  Typisierung für den Returnwert der Protokoll-ID
  TYPES numc6 TYPE n LENGTH 6.


    CLASS-METHODS: protocol_failure
            IMPORTING
            company TYPE zcompany03
            error_text TYPE string
            error_source TYPE string
            RETURNING VALUE(rv_error_id) TYPE zerror_id03
            RAISING zcx_services_for_customers_03.

  PROTECTED SECTION.

  PRIVATE SECTION.

    CLASS-DATA ls_err_prot TYPE zcs03_err_prot.
    CONSTANTS: numobj_p TYPE znrobj03 VALUE 'Z03NROBJ_P',
               c_email TYPE string VALUE 'email',
               c_company TYPE string VALUE 'company'.

ENDCLASS.



CLASS zclprot_entry_03 IMPLEMENTATION.



  METHOD protocol_failure.

*  Protokollöschung für Testzwecke
*  DELETE from zcs03_err_prot.


*  Eintrag des Fehlers in Protokolltabelle

    SELECT COUNT(*) FROM zcs03_err_prot INTO @DATA(lv_count_lines).
* Prüfen, ob Nummernkreisobjekt existiert, bzw. Einträge in der Tabelle vorhanden sind, wenn nicht anlegen
      IF lv_count_lines = 0.


        zcl_services_for_customers_03=>create_number_range_object( iv_object = numobj_p
                                                                   iv_domlen = 'ZDNRLENDOM03'
                                                                   iv_package = 'ZCASESTUDY03'
                                                                   iv_transport = ''
                                                                   iv_object_text = 'Nummernkreis für rv_error_id' ).

        zcl_services_for_customers_03=>create_numberrange_intervals( iv_rangenr = '01'
                                                                     iv_nrvon   = '0000000001'
                                                                     iv_nrbis   = '0000999999'
                                                                     iv_object = numobj_p  ).

      ENDIF.

*      Eintragsstruktur füllen und dabei automatische ID Vergabe

      TRY.
        ls_err_prot-error_id = CONV numc6( zcl_services_for_customers_03=>get_next_number( iv_object =  numobj_p ) ).
      CATCH cx_nr_object_not_found INTO DATA(nrobjext_notfound).
      ENDTRY.

    ls_err_prot-company = company.
    ls_err_prot-error_source = error_source.
    ls_err_prot-error_text = error_text.
    ls_err_prot-local_created_at = cl_abap_context_info=>get_system_time( ).
    ls_err_prot-local_created_by = cl_abap_context_info=>get_user_technical_name(  ).

    MODIFY zcs03_err_prot FROM @ls_err_prot.

*    Setzen des Returnwertes

    rv_error_id = ls_err_prot-error_id.


*    Entsprechende Ausnahme auslösen abhängig von der Fehlerquelle

    IF error_source = c_email.

        RAISE EXCEPTION TYPE zcx_services_for_customers_03
        EXPORTING
        textid = zcx_services_for_customers_03=>invalid_mail03
        error_comp = CONV #( company )
        error_text = error_text.

    ELSEIF error_source = c_company.

        RAISE EXCEPTION TYPE zcx_services_for_customers_03
        EXPORTING
        textid = zcx_services_for_customers_03=>too_long_comp03
        error_text = error_text.

    ELSE.

        RAISE EXCEPTION TYPE zcx_services_for_customers_03
        EXPORTING
        textid = zcx_services_for_customers_03=>other_error03
        error_comp = CONV #( company )
        error_text = error_text.

    ENDIF.


  ENDMETHOD.

ENDCLASS.
