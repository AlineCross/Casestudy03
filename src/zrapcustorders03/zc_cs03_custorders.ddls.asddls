@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZCS03_CUSTORDERS'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_CS03_CUSTORDERS
  provider contract transactional_query
  as projection on ZR_CS03_CUSTORDERS
  association [1..1] to ZR_CS03_CUSTORDERS as _BaseEntity on $projection.OrderID = _BaseEntity.OrderID
{
  key OrderID,
  CustomerID,
  OrderDate,
  @Semantics: {
    amount.currencyCode: 'Currency'
  }
  OrderTotal,
  Discount,
  Info,
  Status,
  @Consumption: {
    valueHelpDefinition: [ {
      entity.element: 'Currency', 
      entity.name: 'I_CurrencyStdVH', 
      useForValidation: true
    } ]
  }
  Currency,
  
  @Semantics: {
    user.createdBy: true
  }
  LocalCreatedBy,
  @Semantics: {
    systemDateTime.createdAt: true
  }
  LocalCreatedAt,
  @Semantics: {
    user.localInstanceLastChangedBy: true
  }
  LocalLastChangedBy,
  @Semantics: {
    systemDateTime.localInstanceLastChangedAt: true
  }
  LocalLastChangedAt,
  @Semantics: {
    systemDateTime.lastChangedAt: true
  }
  LastChangedAt,
  _BaseEntity
}
