*"* use this source file for your ABAP unit test classes
CLASS ltc_check_email DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA cut TYPE REF TO zcl_services_for_customers__10. " CUT = class under test

    METHODS setup.
    METHODS test_valid_simple     FOR TESTING.
    METHODS test_valid_with_plus  FOR TESTING.
    METHODS test_invalid_no_at    FOR TESTING.
    METHODS test_invalid_two_at   FOR TESTING.
    METHODS test_invalid_bad_tld  FOR TESTING.
    METHODS test_invalid_space    FOR TESTING.
    methods test_invalid_trailing_dot for testing .
methods test_invalid_two_dots for testing.
methods test_invalid_leding_dot for testing.

methods test_invalid_emails for testing.
ENDCLASS.
CLASS ltc_check_email IMPLEMENTATION.

  METHOD setup.
    cut = NEW zcl_services_for_customers__10( ).
  ENDMETHOD.

  METHOD test_valid_simple.
   cl_abap_unit_assert=>assert_true(
      act = cut->check_email( 'user@test.com' )
      msg = 'Expected valid email' ).
       cl_abap_unit_assert=>assert_true(
      act = cut->check_email( 'User.Name@domain.org' )
      msg = 'Expected valid email with uppercase letters' ).
  ENDMETHOD.

  METHOD test_valid_with_plus.
     cl_abap_unit_assert=>assert_true(
      act = cut->check_email( 'User+Name@domain.org' )
      msg = 'Valid email with + rejected' ).
  ENDMETHOD.


  METHOD test_invalid_no_at.
**    TRY.
**        cut->check_email( iv_email = 'user.example.com' ).
**        cl_abap_unit_assert=>fail( 'Expected exception not raised' ).
**      CATCH zcx_services_for_customers_03 INTO DATA(lx).
**        cl_abap_unit_assert=>assert_equals(
**          act = lx->if_t100_message~t100key-msgno
**          exp = zcx_services_for_customers_03=>invalid_mail03-msgid
**          msg = 'Wrong textid for invalid email (no @)' ).
**           " ok
**    ENDTRY.
 cl_abap_unit_assert=>assert_false(
      act = cut->check_email( 'usertest.com' )
      msg = 'Email with no @ must be invalid' ).
  ENDMETHOD.
*
  METHOD test_invalid_two_at.
*    TRY.
 cl_abap_unit_assert=>assert_false(
      act = cut->check_email( 'user@@test.com' )
      msg = 'Email with two @ must be invalid' ).
*        cut->check_email( iv_email = 'a@b@c.com' ).
*        cl_abap_unit_assert=>fail( 'Expected exception not raised' ).
*      CATCH zcx_services_for_customers_03 INTO DATA(lx).
*      cl_abap_unit_assert=>assert_equals(
*        act = lx->if_t100_message~t100key-msgno
*        exp = zcx_services_for_customers_03=>invalid_mail03-msgid
*        msg = 'Wrong exception textid for two @ ' ).
*
*        " ok
*    ENDTRY.
  ENDMETHOD.
*
 METHOD test_invalid_bad_tld.
*    TRY.
 cl_abap_unit_assert=>assert_false(
      act = cut->check_email( 'user@test..ltd' )
      msg = 'Email with invalid domain ..ltd must be invalid' ).
*        cut->check_email( iv_email = 'user@domain.c' ).
*        cl_abap_unit_assert=>fail( 'Expected exception not raised' ).
*      CATCH zcx_services_for_customers_03 INTO DATA(lx).
*      cl_abap_unit_assert=>assert_equals(
*        act = lx->if_t100_message~t100key-msgno
*        exp = zcx_services_for_customers_03=>invalid_mail03-msgid
*        msg = 'Wrong exception textid for invalid bad tld' ).
*        " ok
*
*    ENDTRY.
  ENDMETHOD.
*
 METHOD test_invalid_space.
*    TRY.
cl_abap_unit_assert=>assert_false(
      act = cut->check_email( 'user name@test.com' )
      msg = 'Email with space must be invalid' ).
*        cut->check_email( iv_email = 'us er@example.com' ).
*        cl_abap_unit_assert=>fail( 'Expected exception not raised' ).
*      CATCH zcx_services_for_customers_03 INTO DATA(lx).
*      cl_abap_unit_assert=>assert_equals(
*        act = lx->if_t100_message~t100key-msgno
*        exp = zcx_services_for_customers_03=>invalid_mail03-msgid
*        msg = 'Wrong exception textid for invalid space' ).
*        " ok
*    ENDTRY.
  ENDMETHOD.
  METHOD test_invalid_two_dots.
cl_abap_unit_assert=>assert_false(
      act = cut->check_email( 'username@test..com' )
      msg = 'Email with two dots must be invalid' ).

  ENDMETHOD.
METHOD test_invalid_trailing_dot.
*  TRY.
 cl_abap_unit_assert=>assert_false(
      act = cut->check_email( 'user@test.com.' )
      msg = 'Email ending with dot must be invalid' ).
*      cut->check_email( iv_email = 'user@test.com.' ).
*      cl_abap_unit_assert=>fail( 'Expected exception for trailing dot' ).
*    CATCH zcx_services_for_customers_03 INTO DATA(lx).
*      cl_abap_unit_assert=>assert_equals(
*        act = lx->if_t100_message~t100key-msgno
*        exp = zcx_services_for_customers_03=>invalid_mail03-msgid
*        msg = 'Wrong exception textid for trailing dot' ).
*  ENDTRY.
ENDMETHOD.
 METHOD test_invalid_emails.
    " leading dot
    cl_abap_unit_assert=>assert_false(
      act = cut->check_email( '.user@test.com' )
      msg = 'Email with leading dot must be invalid' ).


  ENDMETHOD.


  METHOD test_invalid_leding_dot.
 cl_abap_unit_assert=>assert_false(
      act = cut->check_email( '.user@test.com' )
      msg = 'Email with leading dot must be invalid' ).
  ENDMETHOD.

ENDCLASS.
*CLASS ltc_check_company DEFINITION FINAL FOR TESTING
*  DURATION SHORT
*  RISK LEVEL HARMLESS.
*
*  PRIVATE SECTION.
*    DATA cut TYPE REF TO zcl_services_for_customers__10 . " class under test
*    DATA ls_customer TYPE zscustomers. " reuse customer type
*
*    METHODS setup.
*    METHODS test_valid_company   FOR TESTING.
*    METHODS test_empty_company   FOR TESTING.
*    METHODS test_too_long_company FOR TESTING.
*ENDCLASS.
*
*CLASS ltc_check_company IMPLEMENTATION.
*
*  METHOD setup.
*    cut = NEW zcl_services_for_customers__10( ).
*    CLEAR ls_customer.
*  ENDMETHOD.
*
*  METHOD test_valid_company.
*    ls_customer-company = 'SAP AG'.
*    TRY.
*        cut->check_company( CHANGING cs_cust = ls_customer ).
*        cl_abap_unit_assert=>assert_true( act = abap_true msg = 'Valid company should not raise' ).
*      CATCH zclexc_class_03.
*        cl_abap_unit_assert=>fail( 'Unexpected exception for valid company' ).
*    ENDTRY.
*  ENDMETHOD.
*
*  METHOD test_empty_company.
*    ls_customer-company = ''.
*    TRY.
*        cut->check_company( CHANGING cs_cust = ls_customer ).
*        cl_abap_unit_assert=>fail( 'Expected exception for empty company' ).
*      CATCH zclexc_class_03 INTO DATA(lx).
*        cl_abap_unit_assert=>assert_equals(
*          act = lx->if_t100_message~t100key-msgno
*          exp = zclexc_class_03=>zcx_other_error03-msgno
*          msg = 'Wrong exception textid for empty company' ).
*    ENDTRY.
*  ENDMETHOD.
*
*  METHOD test_too_long_company.
*    ls_customer-company = repeat( val = 'X' occ = 61 ). " string of 61 X's
*    TRY.
*        cut->check_company( CHANGING cs_cust = ls_customer ).
*        cl_abap_unit_assert=>fail( 'Expected exception for too long company' ).
*      CATCH zclexc_class_03 INTO data(lx).
*        cl_abap_unit_assert=>assert_equals(
*          act = lx->if_t100_message~t100key-msgno
*          exp = zclexc_class_03=>zcx_too_long_comp03-msgno
*          msg = 'Wrong exception textid for long company' ).
*    ENDTRY.
*  ENDMETHOD.
*
*ENDCLASS.
