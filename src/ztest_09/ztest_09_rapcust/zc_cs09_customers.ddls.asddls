@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'ZCS09_CUSTOMERS'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_CS09_CUSTOMERS
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_CS09_CUSTOMERS
  association [1..1] to ZR_CS09_CUSTOMERS as _BaseEntity on $projection.CUSTOMERID = _BaseEntity.CUSTOMERID
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
    Amount.Currencycode: 'Currency'
  }
  SalesVolume,
  @Consumption: {
    Valuehelpdefinition: [ {
      Entity.Element: 'Currency', 
      Entity.Name: 'I_CurrencyStdVH', 
      Useforvalidation: true
    } ]
  }
  Currency,
  @Semantics: {
    Amount.Currencycode: 'CurrencyTarget'
  }
  SalesVolumeTarget,
  @Consumption: {
    Valuehelpdefinition: [ {
      Entity.Element: 'Currency', 
      Entity.Name: 'I_CurrencyStdVH', 
      Useforvalidation: true
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
    User.Createdby: true
  }
  LocalCreatedBy,
  @Semantics: {
    Systemdatetime.Createdat: true
  }
  LocalCreatedAt,
  @Semantics: {
    User.Localinstancelastchangedby: true
  }
  LocalLastChangedBy,
  @Semantics: {
    Systemdatetime.Localinstancelastchangedat: true
  }
  LocalLastChangedAt,
  @Semantics: {
    Systemdatetime.Lastchangedat: true
  }
  LastChangedAt,
  _BaseEntity
}
