CLASS zclbadi_add_info_cust03 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_badi_interface .
    INTERFACES zibadi_add_info_cust03 .
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zclbadi_add_info_cust03 IMPLEMENTATION.

METHOD zibadi_add_info_cust03~get_address_info.
ENDMETHOD.

  METHOD if_oo_adt_classrun~main.
    out->write( 'Custom logic for implementing the BAdI zclbadi_add_info_cust03 can be implemented here.' ) .
  ENDMETHOD.

ENDCLASS.
