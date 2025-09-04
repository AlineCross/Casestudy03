@AbapCatalog.viewEnhancementCategory: [#PROJECTION_LIST]
@AbapCatalog.extensibility.dataSources: [ 'Customers' ]
@AbapCatalog.extensibility.elementSuffix: 'ZVP'
@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZCS03_CUSTOMERS000'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_CS03_CUSTOMERS000
  provider contract transactional_query
  as projection on ZR_CS03_CUSTOMERS000 as Customers
  association [1..1] to ZR_CS03_CUSTOMERS000 as _BaseEntity on $projection.CustomerID = _BaseEntity.CustomerID
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
  _BaseEntity
}
