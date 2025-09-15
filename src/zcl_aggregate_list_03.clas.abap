CLASS zcl_aggregate_list_03 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_aggregate_list_03 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*  Abfrage der Daten über die angelegte CDS-View

  SELECT * FROM ZCS03customers_query INTO TABLE @DATA(lt_cust_order).

*   Sortieren des Datensatzes nach Kundennummer

  SORT lt_cust_order BY CustomerId.

*   Ausgabe der Daten über die Console

  out->write( name = 'Maximalumsatz pro Kunde' data = lt_cust_order ).

  ENDMETHOD.

ENDCLASS.
