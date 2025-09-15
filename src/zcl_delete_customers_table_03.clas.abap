CLASS zcl_delete_customers_table_03 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
      INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_delete_customers_table_03 IMPLEMENTATION.



  METHOD if_oo_adt_classrun~main.

*   Löschung der Daten aus der Tabelle zcs03_customers

    DELETE FROM zcs03_customers .

  ENDMETHOD.

ENDCLASS.
