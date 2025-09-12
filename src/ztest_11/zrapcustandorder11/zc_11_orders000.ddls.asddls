@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: 'Orders'
}
@AccessControl.authorizationCheck: #MANDATORY
define view entity ZC_11_ORDERS000
  as projection on ZC_11_ORDERS
  association [1..1] to ZC_11_ORDERS as _BaseEntity on $projection.CUSTOMERID = _BaseEntity.CUSTOMERID and $projection.ORDERID = _BaseEntity.ORDERID
{
  @Endusertext: {
    Label: 'Kundennummer', 
    Quickinfo: 'Kundennummer'
  }
  key CustomerId,
  @Endusertext: {
    Label: 'Bestellnummer', 
    Quickinfo: 'Bestellnummer'
  }
  key OrderId,
  OrderDate,
  @Endusertext: {
    Label: 'Summe der Bestellung', 
    Quickinfo: 'Summe der Bestellung'
  }
  @Semantics: {
    Amount.Currencycode: 'CURRENCY'
  }
  OrderTotal,
  @Endusertext: {
    Label: 'Rabatt', 
    Quickinfo: 'Rabatt'
  }
  Discount,
  @Endusertext: {
    Label: 'Bestellinformation', 
    Quickinfo: 'Bestellinformation'
  }
  Info,
  @Endusertext: {
    Label: 'Bestellstatus', 
    Quickinfo: 'Bestellstatus'
  }
  Status,
  @Endusertext: {
    Label: 'Währung', 
    Quickinfo: 'Währungsschlüssel'
  }
  Currency,
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
  _customers : redirected to parent ZC_11_CUSTOM,
  _BaseEntity
}
