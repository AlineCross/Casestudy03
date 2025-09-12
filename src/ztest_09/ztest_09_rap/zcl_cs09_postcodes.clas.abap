CLASS zcl_cs09_postcodes DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
  INTERFACES if_sadl_exit_calc_element_read.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_cs09_postcodes IMPLEMENTATION.
METHOD if_sadl_exit_calc_element_read~get_calculation_info.
    IF iv_entity <> 'ZC_CS09_POSTCODES'.
      RAISE EXCEPTION TYPE zcx_sadl_exit_virtual_element.
    ENDIF.

    LOOP AT it_requested_calc_elements ASSIGNING FIELD-SYMBOL(<fs_calc_element>).
      CASE <fs_calc_element>.
        WHEN 'DISTINCTPSTCDS'.
            INSERT `POSTCODE` INTO TABLE et_requested_orig_elements.

*        WHEN 'ANOTHERELEMENT'.
*          INSERT `` ...

        WHEN OTHERS.
          RAISE EXCEPTION TYPE zcx_sadl_exit_virtual_element.
      ENDCASE.
    ENDLOOP.
  ENDMETHOD.

  METHOD if_sadl_exit_calc_element_read~calculate.


    DATA lt_original_data TYPE STANDARD TABLE OF ZC_CS09_POSTCODES WITH DEFAULT KEY.
    lt_original_data = CORRESPONDING #( it_original_data ).

    DATA(dstnctpstcds) = 0.

    LOOP AT lt_original_data ASSIGNING FIELD-SYMBOL(<fs_original_data>).
      dstnctpstcds = dstnctpstcds + 1.
    ENDLOOP.

    LOOP AT lt_original_data INTO <fs_original_data>.
      <fs_original_data>-distinctpstcds = dstnctpstcds.
    ENDLOOP.

    ct_calculated_data = CORRESPONDING #(  lt_original_data ).

  ENDMETHOD.

ENDCLASS.
