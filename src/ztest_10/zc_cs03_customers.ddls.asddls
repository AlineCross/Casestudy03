@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZCS03_CUSTOMERS'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_CS03_CUSTOMERS
  
  as projection on ZR_CS03_CUSTOMERS
  association [1..1] to ZR_CS03_CUSTOMERS as _customer on $projection.CustomerID = _customer.CustomerID
{
  key CustomerID,
  Salutation,
  LastName,
  FirstName,
  Company,
  Street,
  City,
  Country,
  Postcode,
  AccLock,
  @Semantics: {
    amount.currencyCode: 'Currency'
  }
  SalesVolume,
  @Consumption: {
    valueHelpDefinition: [ {
      entity.element: 'Currency', 
      entity.name: 'I_CurrencyStdVH', 
      useForValidation: true
    } ]
  }
  Currency,
  @Semantics: {
    amount.currencyCode: 'CurrencyTarget'
  }
  SalesVolumeTarget,
  @Consumption: {
    valueHelpDefinition: [ {
      entity.element: 'Currency', 
      entity.name: 'I_CurrencyStdVH', 
      useForValidation: true
    } ]
  }
  CurrencyTarget,
  ChangeRateDate,
  Fax,
  Phone,
  Email,
  Url,
  Language,
  WebLogin,
  WebPwd,
  Memo,
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
  _customer
}
