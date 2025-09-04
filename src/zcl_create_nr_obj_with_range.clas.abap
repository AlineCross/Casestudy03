CLASS zcl_create_nr_obj_with_range DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_create_nr_obj_with_range IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

      zcl_services_for_customers_03=>create_number_range_object( iv_object      = 'Z03NROBJ_C'
                                                                 iv_domlen      = 'ZDCUSTOMER_ID03'
                                                                 iv_package     = 'ZCASESTUDY03'
                                                                 iv_transport   = ''
                                                                 iv_object_text = 'Nummernkreisobjekt für customer_ID'
                                                                ).
      COMMIT WORK AND WAIT .
*
      zcl_services_for_customers_03=>create_numberrange_intervals( iv_object  = 'Z03NROBJ_C'
                                                                   iv_rangenr = '01'
                                                                   iv_nrvon   = '000001'
                                                                   iv_nrbis   = '999999'
                                                                 ).
      COMMIT WORK AND WAIT.

*      zcl_services_for_customers_03=>change_numberrange_intervals( iv_object  = 'Z03NROBJ_C'
*                                                                         iv_rangenr = '01'
*                                                                         iv_nrvon   = '000001'
*                                                                         iv_nrbis   = '999999'
*                                                                  ).
*      COMMIT WORK.

*      zcl_services_for_customers_03=>read_numberrange_intervals( iv_object  = 'Z03NROBJ_C'
*                                                                 iv_rangenr = '01'
*       ).
*      COMMIT WORK.

*      zcl_services_for_customers_03=>delete_numberrange_intervals( iv_object  = 'Z03NROBJ_C'
*                                                                         iv_rangenr = '01'
*                                                                         iv_nrvon   = '000001'
*                                                                         iv_nrbis   = '999999'
*                                                                  ).
*      COMMIT WORK AND WAIT.

*      zcl_services_for_customers_03=>delete_number_range_object( iv_object = 'Z03NROBJ_C' ).
*      COMMIT WORK AND WAIT.

  ENDMETHOD.
ENDCLASS.
