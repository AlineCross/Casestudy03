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
        RESULT result,
      update_sales_volume FOR DETERMINE ON MODIFY
            IMPORTING keys FOR ZrCs03Custorders~update_sales_volume.
ENDCLASS.

CLASS LHC_ZR_CS03_CUSTORDERS IMPLEMENTATION.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.
  METHOD update_sales_volume.

      DATA volumerate_upd TYPE TABLE FOR UPDATE zr_cs03_customers000.
      data lv_ordr_total type p   length 14 decimals  2.
    READ ENTITIES OF zr_cs03_customers000 ENTITY
    ZrCs03Customers000 FIELDS (  Currency CurrencyTarget SalesVolume SalesVolumeTarget ChangeRateDate )
    WITH CORRESPONDING #( keys )
    RESULT DATA(customers).

    LOOP AT customers INTO DATA(customer).
     SELECT SUM( order_total )
    FROM zcs03_custorders
    WHERE customer_id = @customer-CustomerID

     iNTO @data(lv_total_active).


  " Get sum from draft orders
  SELECT SUM( ordertotal )

    FROM zcs03_cstrders_d
    WHERE customerid = @customer-CustomerID
         iNTO @data(lv_total_draft).

  " Add both
 lv_ordr_total = lv_total_active + lv_total_draft.


      IF customer-ChangeRateDate IS INITIAL.
        customer-ChangeRateDate = cl_abap_context_info=>get_system_date( ).
      ENDIF.

      IF customer-CurrencyTarget IS INITIAL.
        customer-CurrencyTarget = 'USD'.
      ENDIF.

      IF customer-Currency IS INITIAL OR customer-Currency = '0'.
        customer-Currency = 'EUR'.
      ENDIF.

*
      select single from zcs03_customers fields currency_conversion( amount =  @lv_ordr_total ,
       source_currency = @customer-Currency ,
       target_currency = @customer-CurrencyTarget ,
       exchange_rate_date = @customer-ChangeRateDate ) as salesVolumeRate
       into @data(SalesVolume) .



*          SELECT SINGLE FROM zr_cs03_cust_conv_sales( pa_currency_target = @customer-CurrencyTarget,
*          pa_customer_id = @customer-CustomerID,
*          pa_date = @customer-ChangeRateDate, pa_currency = @customer-Currency )
*          FIELDS SalesVolumeTarget, SalesVolume
*          INTO ( @customer-SalesVolumeTarget, @customer-SalesVolume ).
*          MODIFY customers FROM customer.
*        CATCH cx_sy_itab_line_not_found.
*        CATCH cx_root INTO DATA(ocx_root).
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
