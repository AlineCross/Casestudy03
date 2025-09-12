CLASS zcl_cs03_num_orders DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_sadl_exit .
    INTERFACES if_sadl_exit_calc_element_read .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_cs03_num_orders IMPLEMENTATION.


  METHOD if_sadl_exit_calc_element_read~calculate.

  DATA lt_original_data TYPE STANDARD TABLE OF ZC_CS03_CUSTOMERS000 WITH DEFAULT KEY.
    lt_original_data = CORRESPONDING #( it_original_data ).
    DATA id_counter TYPE i VALUE 0.

    DATA lt_custorders TYPE standard TABLE of zcs03_custorders WITH DEFAULT KEY.
    SELECT * FROM zcs03_custorders INTO TABLE @lt_custorders.
    SORT lt_custorders BY customer_id.

    LOOP AT lt_original_data ASSIGNING FIELD-SYMBOL(<fs_original_data>).
    id_counter = 0.
     LOOP AT lt_custorders INTO DATA(ls_custorders).
     IF ls_custorders-customer_id = <fs_original_data>-customerID.
        id_counter = id_counter + 1.
     ENDIF.
      ENDLOOP.
      <fs_original_data>-number_of_orders = id_counter.
    ENDLOOP.

    ct_calculated_data = CORRESPONDING #(  lt_original_data ).
  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~get_calculation_info.

   IF iv_entity <> 'ZC_CS03_CUSTOMERS000'.
      RAISE EXCEPTION TYPE zcx_sadl_exit_virtual_element.
    ENDIF.

    LOOP AT it_requested_calc_elements ASSIGNING FIELD-SYMBOL(<fs_calc_element>).
      CASE <fs_calc_element>.
        WHEN 'NUMBER_OF_ORDERS'.
            INSERT `CUSTOMERID` INTO TABLE et_requested_orig_elements.

*        WHEN 'ANOTHERELEMENT'.
*          INSERT `` ...

        WHEN OTHERS.
          RAISE EXCEPTION TYPE zcx_sadl_exit_virtual_element.
      ENDCASE.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
