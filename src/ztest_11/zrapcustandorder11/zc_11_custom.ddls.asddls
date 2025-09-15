@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: 'Customers'
}
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZC_11_CUSTOM
  provider contract transactional_query
  as projection on ZR_11_CUSTOM
  association [1..1] to ZR_11_CUSTOM as _BaseEntity on $projection.Customer_Id = _BaseEntity.Customer_Id
{
  @EndUserText: {
    label: 'Kundennummer', 
    quickInfo: 'Kundennummer'
  }
  key Customer_Id,
  @EndUserText: {
    label: 'Anrede', 
    quickInfo: 'Anrede'
  }
  Salutation,
  @EndUserText: {
    label: 'Nachname', 
    quickInfo: 'Nachname'
  }
  LastName,
  @EndUserText: {
    label: 'Vorname', 
    quickInfo: 'Vorname'
  }
  FirstName,
  @EndUserText: {
    label: 'Firma', 
    quickInfo: 'Firma'
  }
  Company,
  @EndUserText: {
    label: 'Strasse', 
    quickInfo: 'Strasse'
  }
  Street,
  @EndUserText: {
    label: 'Stadt', 
    quickInfo: 'Stadt'
  }
  City,
  @EndUserText: {
    label: 'Land/Region', 
    quickInfo: 'Land/Region der Gesellschaft'
  }
  Country,
  @EndUserText: {
    label: 'Postleitzahl', 
    quickInfo: 'Postleitzahl'
  }
  Postcode,
  @EndUserText: {
    label: '', 
    quickInfo: 'Buchhalterische Sperre'
  }
  AccLock,
  @EndUserText: {
    label: 'letzte Änderung am', 
    quickInfo: 'letzte Änderung des Stammsatzes'
  }
  LastDate,
  @EndUserText: {
    label: 'sales', 
    quickInfo: 'sales volume'
  }
  SalesVolume,
  @Semantics.currencyCode: true
  Currency,
  @EndUserText: {
    label: 'sales', 
    quickInfo: 'sales volume'
  }
  SalesVolumeTarget,
  CurrencyTarget,
  ChangeRateDate,
  @EndUserText: {
    label: 'Fax Nummer', 
    quickInfo: 'Fax Nummer'
  }
  Fax,
  @EndUserText: {
    label: 'Telefonnummer', 
    quickInfo: 'Telefonnummer'
  }
  Phone,
  @EndUserText: {
    label: 'E-Mail', 
    quickInfo: 'E-Mail'
  }
  Email,
  @EndUserText: {
    label: 'URL Adresse', 
    quickInfo: 'URL Adresse'
  }
  Url,
  @EndUserText: {
    label: 'Sprachenschlüssel', 
    quickInfo: 'Sprachenschlüssel'
  }
  Language,
  @EndUserText: {
    label: 'Weblogin für Kunden', 
    quickInfo: 'Weblogin für Kundendaten'
  }
  WebLogin,
  @EndUserText: {
    label: 'Webpassword Kunde', 
    quickInfo: 'Webpassword für Kundendaten'
  }
  WebPwd,
  @EndUserText: {
    label: 'Allgemeine Info', 
    quickInfo: 'Allgemeine Informationen'
  }
  Memo,
  @EndUserText: {
    label: 'Angelegt von', 
    quickInfo: 'Angelegt von Benutzer'
  }
  LocalCreatedBy,
  @EndUserText: {
    label: 'Angelegt am', 
    quickInfo: 'Anlegedatum/-uhrzeit'
  }
  LocalCreatedAt,
  @EndUserText: {
    label: 'Geändert von', 
    quickInfo: 'Letzte Änderung der lokalen Instanz durch Benutzer'
  }
  LocalLastChangedBy,
  @EndUserText: {
    label: 'Geändert am', 
    quickInfo: 'Datum und Uhrzeit der letzten Änderung der lokalen Instanz'
  }
  LocalLastChangedAt,
  @EndUserText: {
    label: 'Geändert am', 
    quickInfo: 'Datum und Uhrzeit der letzten Änderung'
  }
  LastChangedAt,
  @EndUserText: {
    label: 'VIP Status', 
    quickInfo: 'VIP'
  }
  ZzvipZvp,
  _orders : redirected to composition child ZC_11_ORDERS000,
  _BaseEntity
}
