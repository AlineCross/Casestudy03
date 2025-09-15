CLASS zcl_import_raw_customers_03 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
    INTERFACES if_apj_dt_exec_object .
    INTERFACES if_apj_rt_exec_object .
*    METHODS import_csv IMPORTING iv_run_status TYPE zrun_status03.
    METHODS import_csv.

  PROTECTED SECTION.

  PRIVATE SECTION.

    METHODS is_db_table_customers_full RETURNING VALUE(rv_result) TYPE abap_boolean.
    CONSTANTS c_raw_csv_table   TYPE ztablename03 VALUE 'zcs03_casestudyd'.
*    CONSTANTS c_numberrange_counter_reset TYPE zcustomer_id03 VALUE '000001'.
    CONSTANTS c_email   TYPE string VALUE 'email'.
    CONSTANTS c_company TYPE string VALUE 'company'.
    TYPES typ_numc6 TYPE n LENGTH 6.
    DATA gv_timestamp     TYPE abp_creation_tstmpl.
    DATA lo_badi       TYPE REF TO zbadi_add_info_cust03.
    DATA lt_error_ids  TYPE zibadi_add_info_cust03=>tt_failed_addresses.
    DATA lv_badi_count TYPE i VALUE '0'.

ENDCLASS.


CLASS zcl_import_raw_customers_03 IMPLEMENTATION.

  METHOD if_apj_dt_exec_object~get_parameters.
  ENDMETHOD.

  METHOD if_apj_rt_exec_object~execute.
*   for Application Job
    import_csv( ).
  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.
    import_csv( ).
  ENDMETHOD.

  METHOD is_db_table_customers_full.

    SELECT COUNT(*) FROM zcs03_customers INTO @DATA(lv_count_lines).

    IF lv_count_lines = 0.
      rv_result = abap_false.
    ELSE.
      rv_result = abap_true.
    ENDIF.

  ENDMETHOD.
**********************************************************************
  METHOD import_csv.

*   Normierte Daten, Struktur basiert auf die Tabelle ZCS03_CUSTOMERS
    DATA gt_customers_norm TYPE zcs03_tty_customers.

    DATA gt_raw_customers TYPE TABLE OF string.

**********************************************************************
*   Rohe(raw) csv Daten werden für weitere Verarbeitung in ABAP Struktur übernommen
    TYPES: BEGIN OF sty_customer,
             company  TYPE c LENGTH 60,
*           last_name TYPE c LENGTH 25,
*          first_name TYPE c LENGTH 20,
             street   TYPE c LENGTH 50,
             postcode TYPE c LENGTH 6,
             city     TYPE c LENGTH 30,
             media    TYPE c LENGTH 10,
             value1   TYPE c LENGTH 60,
             value2   TYPE c LENGTH 60,
*            vip      TYPE c LENGTH 1,
           END OF sty_customer.

    DATA  s_customer TYPE  sty_customer.

    DATA gt_customers TYPE SORTED TABLE OF sty_customer
    WITH NON-UNIQUE KEY company street postcode city .

**********************************************************************

    SELECT DISTINCT import FROM (c_raw_csv_table) INTO TABLE @gt_raw_customers.

    SORT gt_raw_customers BY table_line.

*   Aufbereitung und Bereinigung der Daten für die weitere Verarbeitung
    LOOP AT gt_raw_customers INTO DATA(ls_raw_customers).

      ls_raw_customers = replace( val = ls_raw_customers sub = `"` with = `` occ = 0 ).

      SPLIT ls_raw_customers AT ';'
      INTO s_customer-company
           s_customer-street
           s_customer-postcode
           s_customer-city
           s_customer-media
           s_customer-value1
           s_customer-value2.
*          s_customer-vip.

      INSERT s_customer INTO TABLE gt_customers.

    ENDLOOP.


*   Gruppenwechsel
    LOOP AT gt_customers ASSIGNING FIELD-SYMBOL(<lt_customers>)
    GROUP BY <lt_customers>-company  ASCENDING.

*      DATA(lv_i_count_Telefon) = 0.
*      DATA(lv_i_count_Telefax) = 0.
*      DATA(lv_i_count_email) = 0.

      APPEND INITIAL LINE TO gt_customers_norm ASSIGNING FIELD-SYMBOL(<ls_customers_norm>).


      LOOP AT GROUP <lt_customers> INTO DATA(ls_customers).

        <ls_customers_norm>-salutation  = ''.
        <ls_customers_norm>-last_name   = ''.
        <ls_customers_norm>-first_name  = ''.

        IF zcl_services_for_customers_03=>check_company( iv_company = ls_customers-company ) = abap_false.
          TRY.
              zclprot_entry_03=>protocol_failure( EXPORTING
                                                      company      = ls_customers-company
                                                      error_text   = CONV #( ls_customers-company )
                                                      error_source = c_company
                                                  RECEIVING
                                                      rv_error_id     =  DATA(error_id)
                                                ).
            CATCH zcx_services_for_customers_03.
          ENDTRY.
          APPEND error_id TO lt_error_ids.
        ELSE.
          <ls_customers_norm>-company  = ls_customers-company.
        ENDIF.

        <ls_customers_norm>-street   = ls_customers-street.
        <ls_customers_norm>-postcode = ls_customers-postcode.
        <ls_customers_norm>-city     = ls_customers-city.

*        CASE ls_customers-media.
*          WHEN ``.
*            lv_i_count_Telefon = lv_i_count_Telefon + 1.
*            IF lv_i_count_Telefon > 1.
*              <ls_customers_norm>-memo  = <ls_customers_norm>-memo && | Telefon: { ls_customers-value1 }/{ ls_customers-value2 },|.
*            ELSE.
*              <ls_customers_norm>-phone = |{ ls_customers-value1 }/{ ls_customers-value2 } |.
*            ENDIF.
*          WHEN `Telefax`.
*            lv_i_count_Telefax = lv_i_count_Telefax + 1.
*            IF lv_i_count_Telefax > 1.
*              <ls_customers_norm>-memo  = <ls_customers_norm>-memo && | Telefax: { ls_customers-value1 }/{ ls_customers-value2 },|.
*            ELSE.
*              <ls_customers_norm>-fax   = |{ ls_customers-value1 }/{ ls_customers-value2 } |.
*            ENDIF.
*          WHEN `Email`.
*            IF zcl_services_for_customers_03=>check_email( iv_email = ls_customers-value1 ) = abap_false.
*              TRY.
*                  zclprot_entry_03=>protocol_failure( EXPORTING
*                                                          company      = ls_customers-company
*                                                          error_text   = CONV #( ls_customers-value1 )
*                                                          error_source = c_email
*                                                      RECEIVING
*                                                          error_id     =  error_id
*                                                     ).
*                CATCH zcx_services_for_customers_03.
*              ENDTRY.
*              APPEND error_id TO lt_error_ids.
*            ELSE.
*              lv_i_count_email = lv_i_count_email + 1.
*              IF lv_i_count_email > 1.
*                <ls_customers_norm>-memo  = <ls_customers_norm>-memo && | Email: {  ls_customers-value1 } ,|.
*              ELSE.
*                <ls_customers_norm>-email = ls_customers-value1.
*              ENDIF.
*            ENDIF.
*          WHEN OTHERS.
*            <ls_customers_norm>-memo  = <ls_customers_norm>-memo && condense( | Unbekannte Medium: { ls_customers-value1 } { ls_customers-value2 } ,| ).
*        ENDCASE.
        CASE ls_customers-media.

*        Eintrag der Telefonnummern

          WHEN ``.

            IF <ls_customers_norm>-phone IS INITIAL.
              <ls_customers_norm>-phone = |{ ls_customers-value1 }/{ ls_customers-value2 } |.
            ELSEIF <ls_customers_norm>-memo IS INITIAL.
              <ls_customers_norm>-memo  = | Telefon: { ls_customers-value1 }/{ ls_customers-value2 }|.
            ELSE.
              <ls_customers_norm>-memo  = <ls_customers_norm>-memo && |, Telefon: { ls_customers-value1 }/{ ls_customers-value2 }|.
            ENDIF.

*           Eintrag der Faxgerätnummern

          WHEN `Telefax`.
            IF <ls_customers_norm>-fax  IS INITIAL.
              <ls_customers_norm>-fax  = |{ ls_customers-value1 }/{ ls_customers-value2 } |.
            ELSEIF <ls_customers_norm>-memo IS INITIAL.
              <ls_customers_norm>-memo  = | Telefax: { ls_customers-value1 }/{ ls_customers-value2 }|.
            ELSE.
              <ls_customers_norm>-memo  = <ls_customers_norm>-memo && |, Telefax: { ls_customers-value1 }/{ ls_customers-value2 },|.
            ENDIF.

*         Eintrag der Email-Adressen

          WHEN `Email`.
            IF zcl_services_for_customers_03=>check_email( iv_email = ls_customers-value1 ) = abap_false.
              TRY.

*          Wenn der Email-Check einen Fehler ergibt, Eintrag in die Protokolltabelle

                  zclprot_entry_03=>protocol_failure( EXPORTING
                                                          company      = ls_customers-company
                                                          error_text   = CONV #( ls_customers-value1 )
                                                          error_source = c_email
                                                      RECEIVING
                                                          rv_error_id     =  error_id
                                                     ).
                CATCH zcx_services_for_customers_03.

              ENDTRY.

              APPEND error_id TO lt_error_ids.

            ELSE.

*            Da kein Fehler Eintrag der Email-Adresse

              IF <ls_customers_norm>-email IS INITIAL.
                <ls_customers_norm>-email = ls_customers-value1.
              ELSEIF <ls_customers_norm>-memo IS INITIAL.
                <ls_customers_norm>-memo  = | Email: {  ls_customers-value1 }|.
              ELSE.
                <ls_customers_norm>-memo  = <ls_customers_norm>-memo && |, Email: {  ls_customers-value1 }|.
              ENDIF.

            ENDIF.

          WHEN OTHERS.

*          Eintrag unbekannter Medien in das Memo-Feld

            IF <ls_customers_norm>-memo IS INITIAL.
              <ls_customers_norm>-memo  = condense( | Unbekanntes Medium: { ls_customers-value1 } { ls_customers-value2 }| ).
            ELSE.
              <ls_customers_norm>-memo  = <ls_customers_norm>-memo && condense( |, Unbekanntes Medium: { ls_customers-value1 } { ls_customers-value2 }| ).
            ENDIF.

        ENDCASE.

        <ls_customers_norm>-language = sy-langu.
        <ls_customers_norm>-country  = 'DE'.

*        Befüllen der Felder für die Änderungs- und Erstellungszeitpunkte

        GET TIME STAMP FIELD gv_timestamp.
        <ls_customers_norm>-last_date = cl_abap_context_info=>get_system_date( ).
        <ls_customers_norm>-local_created_at = gv_timestamp.
        <ls_customers_norm>-local_created_by = sy-uname.
        <ls_customers_norm>-local_last_changed_at = gv_timestamp.
        <ls_customers_norm>-local_last_changed_by = sy-uname.
        <ls_customers_norm>-last_changed_at = gv_timestamp.

      ENDLOOP.

    ENDLOOP.

*   Reduzierung der neuen Datensätze um die, die schon in der Datenbank vorhanden sind

    IF is_db_table_customers_full(  ) = abap_true.

      LOOP AT gt_customers_norm ASSIGNING <ls_customers_norm>.

        SELECT * FROM zcs03_customers
        WHERE company  = @<ls_customers_norm>-company
        AND   street   = @<ls_customers_norm>-street
        AND   postcode = @<ls_customers_norm>-postcode
        AND   city     = @<ls_customers_norm>-city
        INTO TABLE @FINAL(lt_exist_customers).

*       Der neue Datensatz ist in Customers vorhanden? Dann aus der neuen Tabelle löschen

        IF lines( lt_exist_customers ) > 0. "Es können durchaus mehrere sein
          DELETE gt_customers_norm INDEX sy-tabix.
        ENDIF.

      ENDLOOP.

    ENDIF.

*   Den eventuel reduzierten neue Datensätze Customer_ID vergeben

    LOOP AT gt_customers_norm ASSIGNING <ls_customers_norm>.

*      Counter für neue Adressen zur Übergabe an das BAdI

      <ls_customers_norm>-customer_id = CONV typ_numc6( zcl_services_for_customers_03=>get_next_number( iv_object = 'Z03NROBJ_C'  ) ).
      lv_badi_count = lv_badi_count + 1.
    ENDLOOP.

    IF lines( gt_customers_norm ) > 0.
      TRY.
          MODIFY zcs03_customers FROM TABLE @gt_customers_norm.
          COMMIT WORK AND WAIT.
        CATCH cx_root.
      ENDTRY.
    ENDIF.

*   Aufruf des BAdI zur Übergabe der Fehler-IDs und der Anzahl der neu angelegten Adressen

    GET BADI lo_badi.

    CALL BADI lo_badi->get_address_info
      EXPORTING
        it_addresses  = lt_error_ids
        new_add_count = lv_badi_count.
  ENDMETHOD.


ENDCLASS.
