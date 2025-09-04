*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
class lcl_import_data definition create public.

        public section.
          TYPES ty_raw_data TYPE TABLE OF ztl_00_casestudy WITH DEFAULT KEY.
          TYPES ty_raw_data_1 TYPE TABLE OF ztl_00_casestudy WITH DEFAULT KEY.
          TYPES ty_raw_data_2 TYPE TABLE OF ztl_00_casestudy WITH DEFAULT KEY.
          TYPES:
                 BEGIN OF ty_sep_string,
                    company TYPE string,
                    street TYPE string,
                    postcode TYPE string,
                    city TYPE string,
                    communication1 TYPE string,
                    communication2 TYPE string,
                    cominfo TYPE string,
                    END OF ty_sep_string,
                 ty_sep_strings TYPE TABLE OF ty_sep_string WITH DEFAULT KEY.

        METHODS: constructor,
                 get_lt_raw_data RETURNING value(r_result) TYPE ty_raw_data_1,
                 set_lt_raw_data IMPORTING i_lt_raw_data TYPE ty_raw_data_2,
                 separate_string,
                 get_lt_sep_strings RETURNING value(r_result) TYPE ty_sep_strings,
                 get_counter RETURNING value(r_result) TYPE i.


        protected section.
        private section.
          DATA lt_raw_data TYPE TABLE OF ztl_00_casestudy.
          DATA ls_sep_string TYPE ty_sep_string.
          DATA lt_sep_strings TYPE TABLE OF ty_sep_string.
          DATA counter TYPE i VALUE 1.



      endclass.

      class lcl_import_data implementation.

  method constructor.

    SELECT DISTINCT * FROM ztl_00_casestudy INTO TABLE @lt_raw_data.

  endmethod.




 method separate_string.
    LOOP AT lt_raw_data INTO DATA(ls_raw_data).
        REPLACE ALL OCCURRENCES OF '"' in ls_raw_data-import WITH ''.
        SPLIT ls_raw_data-import at ';' into ls_sep_string-company ls_sep_string-street ls_sep_string-postcode ls_sep_string-city
        ls_sep_string-cominfo ls_sep_string-communication1 ls_sep_string-communication2.
        APPEND ls_sep_string TO lt_sep_strings.
        counter = counter + 1.
    ENDLOOP.
  endmethod.


  method get_lt_raw_data.
    r_result = me->lt_raw_data.
  endmethod.

  method set_lt_raw_data.
    me->lt_raw_data = i_lt_raw_data.
  endmethod.



  method get_lt_sep_strings.
    r_result = me->lt_sep_strings.
  endmethod.

  method get_counter.
    r_result = me->counter.
  endmethod.

endclass.
