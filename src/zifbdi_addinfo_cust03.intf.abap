INTERFACE zifbdi_addinfo_cust03
  PUBLIC .


  INTERFACES if_badi_interface .

  TYPES tt_failed_addresses TYPE TABLE OF string.

  METHODS get_address_info
    IMPORTING it_addresses  TYPE tt_failed_addresses
              new_add_count TYPE i.

ENDINTERFACE.
