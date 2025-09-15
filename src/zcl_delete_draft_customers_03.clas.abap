CLASS zcl_delete_draft_customers_03 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
      INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_delete_draft_customers_03 IMPLEMENTATION.



  METHOD if_oo_adt_classrun~main.

*    Löschung der Testdaten aus den Tabellen

    DELETE FROM zcs03_cstmr000_d .
    DELETE FROM zcs03_cstrders_d.

    DELETE FROM zcs11_cstmr000_d .
    DELETE FROM zcs11_cstrders_d.

  ENDMETHOD.

ENDCLASS.
