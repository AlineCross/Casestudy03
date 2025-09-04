CLASS zcl_fill_postcode_city DEFINITION
  PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.

CLASS zcl_fill_postcode_city IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA lt_data TYPE STANDARD TABLE OF zcs03_postcode.

    lt_data = VALUE #(
      ( postcode = '10115' city = 'Berlin' )
      ( postcode = '80331' city = 'Munich' )
      ( postcode = '20095' city = 'Hamburg' )
      ( postcode = '50667' city = 'Cologne' )
      ( postcode = '60549' city = 'Frankfurt' )
    ).

    MODIFY zcs03_postcode FROM TABLE @lt_data.
    COMMIT WORK.

    out->write( |Postcode → City mapping inserted successfully.| ).
  ENDMETHOD.
ENDCLASS.

