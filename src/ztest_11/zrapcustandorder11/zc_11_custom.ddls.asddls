@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: 'Customers'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_11_CUSTOM
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_11_CUSTOM
  association [1..1] to ZR_11_CUSTOM as _BaseEntity on $projection.CUSTOMERID = _BaseEntity.CUSTOMERID
{
  @Endusertext: {
    Label: 'Kundennummer', 
    Quickinfo: 'Kundennummer'
  }
  key CustomerId,
  @Endusertext: {
    Label: 'Anrede', 
    Quickinfo: 'Anrede'
  }
  Salutation,
  @Endusertext: {
    Label: 'Nachname', 
    Quickinfo: 'Nachname'
  }
  LastName,
  @Endusertext: {
    Label: 'Vorname', 
    Quickinfo: 'Vorname'
  }
  FirstName,
  @Endusertext: {
    Label: 'Firma', 
    Quickinfo: 'Firma'
  }
  Company,
  @Endusertext: {
    Label: 'Strasse', 
    Quickinfo: 'Strasse'
  }
  Street,
  @Endusertext: {
    Label: 'Stadt', 
    Quickinfo: 'Stadt'
  }
  City,
  @Endusertext: {
    Label: 'Land/Region', 
    Quickinfo: 'Land/Region der Gesellschaft'
  }
  Country,
  @Endusertext: {
    Label: 'Postleitzahl', 
    Quickinfo: 'Postleitzahl'
  }
  Postcode,
  @Endusertext: {
    Label: '', 
    Quickinfo: 'Buchhalterische Sperre'
  }
  AccLock,
  @Endusertext: {
    Label: 'letzte Änderung am', 
    Quickinfo: 'letzte Änderung des Stammsatzes'
  }
  LastDate,
  @Endusertext: {
    Label: 'sales', 
    Quickinfo: 'sales volume'
  }
  SalesVolume,
  @Semantics.currencyCode: true
  Currency,
  @Endusertext: {
    Label: 'sales', 
    Quickinfo: 'sales volume'
  }
  SalesVolumeTarget,
  @Semantics.currencyCode: true
  CurrencyTarget,
  ChangeRateDate,
  @Endusertext: {
    Label: 'Fax Nummer', 
    Quickinfo: 'Fax Nummer'
  }
  Fax,
  @Endusertext: {
    Label: 'Telefonnummer', 
    Quickinfo: 'Telefonnummer'
  }
  Phone,
  @Endusertext: {
    Label: 'E-Mail', 
    Quickinfo: 'E-Mail'
  }
  Email,
  @Endusertext: {
    Label: 'URL Adresse', 
    Quickinfo: 'URL Adresse'
  }
  Url,
  @Endusertext: {
    Label: 'Sprachenschlüssel', 
    Quickinfo: 'Sprachenschlüssel'
  }
  Language,
  @Endusertext: {
    Label: 'Weblogin für Kunden', 
    Quickinfo: 'Weblogin für Kundendaten'
  }
  WebLogin,
  @Endusertext: {
    Label: 'Webpassword Kunde', 
    Quickinfo: 'Webpassword für Kundendaten'
  }
  WebPwd,
  @Endusertext: {
    Label: 'Allgemeine Info', 
    Quickinfo: 'Allgemeine Informationen'
  }
  Memo,
  @Endusertext: {
    Label: 'Angelegt von', 
    Quickinfo: 'Angelegt von Benutzer'
  }
  LocalCreatedBy,
  @Endusertext: {
    Label: 'Angelegt am', 
    Quickinfo: 'Anlegedatum/-uhrzeit'
  }
  LocalCreatedAt,
  @Endusertext: {
    Label: 'Geändert von', 
    Quickinfo: 'Letzte Änderung der lokalen Instanz durch Benutzer'
  }
  LocalLastChangedBy,
  @Endusertext: {
    Label: 'Geändert am', 
    Quickinfo: 'Datum und Uhrzeit der letzten Änderung der lokalen Instanz'
  }
  LocalLastChangedAt,
  @Endusertext: {
    Label: 'Geändert am', 
    Quickinfo: 'Datum und Uhrzeit der letzten Änderung'
  }
  LastChangedAt,
  @Endusertext: {
    Label: 'VIP Status', 
    Quickinfo: 'VIP'
  }
  ZzvipZvp,
  _orders : redirected to composition child ZC_11_ORDERS000,
  _BaseEntity
}
