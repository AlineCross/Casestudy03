CLASS zcl_services_for_customers__10 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    CLASS-METHODS check_email
      IMPORTING iv_email          TYPE string
      RETURNING VALUE(email_bool) TYPE abap_bool.
    METHODS check_company
      CHANGING  cs_cust             TYPE zscustomers
      RETURNING VALUE(company_bool) TYPE abap_bool.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_services_for_customers__10 IMPLEMENTATION.
  METHOD check_email.

    IF iv_email IS INITIAL.
      email_bool = abap_false.
    ENDIF.
    CONSTANTS lc_regex TYPE string VALUE
*   `\A[A-Za-z0-9._+-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}\z`.
*   '^[A-Za-z0-9](?!.*\.\.)[A-Za-z0-9._\-]*@[A-Za-z0-9\-]+(\.[A-Za-z0-9\-]+)*\.[A-Za-z]{2,}$'.
*'^[A-Za-z0-9](?!.*\.\.)[A-Za-z0-9._\-]*@[A-Za-z0-9\-]+(\.[A-Za-z0-9\-]+)*\.[A-Za-z]{2,}$'.
* '^[A-Za-z0-9](?!.*\.\.)[A-Za-z0-9._\-]*@[A-Za-z0-9\-]+(\.[A-Za-z0-9\-]+)*\.[A-Za-z]{2,}$'.
 '^[A-Za-z0-9](?!.*\.\.)[A-Za-z0-9._\-]*@[A-Za-z0-9\-]+(\.[A-Za-z0-9\-]+)*\.[A-Za-z]{2,}$'.

    email_bool = xsdbool( matches( val = iv_email regex = lc_regex ) ).

*  IF lv_ok = abap_false.
*    RAISE EXCEPTION TYPE zcx_services_for_customers_03
*      EXPORTING
*        textid = zcx_services_for_customers_03=>invalid_mail03
*       .
*  ENDIF.
  ENDMETHOD.

  METHOD check_company.
    company_bool = abap_true.
    IF cs_cust-company IS INITIAL.
*     RAISE EXCEPTION TYPE zcx_services_for_customers_03
*      EXPORTING
*        textid = zcx_services_for_customers_03=>other_error03
      company_bool = abap_false.
      .
    ENDIF.

    IF strlen( cs_cust-company ) > 60.
*    RAISE EXCEPTION TYPE zcx_services_for_customers_03
*      EXPORTING
*        textid  = zcx_services_for_customers_03=>too_long_comp03
      company_bool = abap_false
              .
    ENDIF.

  ENDMETHOD.


ENDCLASS.
