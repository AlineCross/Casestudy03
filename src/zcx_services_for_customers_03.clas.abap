CLASS zcx_services_for_customers_03 DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_t100_message .
    INTERFACES if_t100_dyn_msg .

    CONSTANTS:
      BEGIN OF other_error03,
        msgid TYPE symsgid VALUE 'ZMSG_CUSTOMERS_03',
        msgno TYPE symsgno VALUE '003',
        attr1 TYPE scx_attrname VALUE 'error_text',
        attr2 TYPE scx_attrname VALUE 'error_comp',
        attr3 TYPE scx_attrname VALUE 'attr3',
        attr4 TYPE scx_attrname VALUE 'attr4',
      END OF other_error03.

    CONSTANTS:
      BEGIN OF invalid_mail03,
        msgid TYPE symsgid VALUE 'ZMSG_CUSTOMERS_03',
        msgno TYPE symsgno VALUE '002',
        attr1 TYPE scx_attrname VALUE 'error_text',
        attr2 TYPE scx_attrname VALUE 'error_comp',
        attr3 TYPE scx_attrname VALUE 'attr3',
        attr4 TYPE scx_attrname VALUE 'attr4',
      END OF invalid_mail03.
       CONSTANTS:
      BEGIN OF statics,
        msgid TYPE symsgid VALUE 'ZMSG_CUSTOMERS_03',
        msgno TYPE symsgno VALUE '004',
        attr1 TYPE scx_attrname VALUE 'customer',
        attr2 TYPE scx_attrname VALUE 'avg',
        attr3 TYPE scx_attrname VALUE 'max',
        attr4 TYPE scx_attrname VALUE 'day',
      END OF statics.

    CONSTANTS:
      BEGIN OF too_long_comp03,
        msgid TYPE symsgid VALUE 'ZMSG_CUSTOMERS_03',
        msgno TYPE symsgno VALUE '001',
        attr1 TYPE scx_attrname VALUE 'error_text',
        attr2 TYPE scx_attrname VALUE 'attr2',
        attr3 TYPE scx_attrname VALUE 'attr3',
        attr4 TYPE scx_attrname VALUE 'attr4',
      END OF too_long_comp03.

    DATA error_comp TYPE string READ-ONLY.
    DATA error_text TYPE string READ-ONLY.

    METHODS constructor
      IMPORTING
        textid   LIKE if_t100_message=>t100key OPTIONAL
        previous LIKE previous OPTIONAL
        error_comp TYPE string OPTIONAL
        error_text    TYPE string OPTIONAL.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcx_services_for_customers_03 IMPLEMENTATION.



  METHOD constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor( previous = previous ).

    me->error_text = error_text.

    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
    IF error_comp IS NOT INITIAL.
    me->error_comp = error_comp.
    ENDIF.
    IF error_text IS NOT INITIAL.
      me->error_text = error_text.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
