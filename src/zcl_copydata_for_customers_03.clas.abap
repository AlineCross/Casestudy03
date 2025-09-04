CLASS zcl_copydata_for_customers_03 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
      INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_copydata_for_customers_03 IMPLEMENTATION.



  METHOD if_oo_adt_classrun~main.


    SELECT * FROM ztl_00_casestudy
      INTO TABLE @FINAL(lt_casestudy).

  INSERT zcs03_casestudy FROM TABLE @lt_casestudy.
*  INSERT zcs03_casestudyd FROM TABLE @lt_casestudy.

  ENDMETHOD.

ENDCLASS.
