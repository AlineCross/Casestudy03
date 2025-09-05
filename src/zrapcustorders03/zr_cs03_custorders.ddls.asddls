@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZCS03_CUSTORDERS'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_CS03_CUSTORDERS
  as select from zcs03_custorders
  association [0..1] to ZR_CS03_CUSTOMERS as _Customers on $projection.CustomerID = _Customers.CustomerID
{
  key order_id                            as OrderID,
      @EndUserText.label: 'Kundennummer'
      customer_id                         as CustomerID,
      @EndUserText.label: 'Datum der Bestellung'
      order_date                          as OrderDate,
      @Semantics.amount.currencyCode: 'Currency'
      order_total                         as OrderTotal,
      discount                            as Discount,
      info                                as Info,
      status                              as Status,
      @Consumption.valueHelpDefinition: [ {
        entity.name: 'I_CurrencyStdVH',
        entity.element: 'Currency',
        useForValidation: true
      } ]
      currency                            as Currency,
      @Semantics.user.createdBy: true
      local_created_by                    as LocalCreatedBy,
      @Semantics.systemDateTime.createdAt: true
      local_created_at                    as LocalCreatedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      local_last_changed_by               as LocalLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at               as LocalLastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at                     as LastChangedAt,

      _Customers
}
