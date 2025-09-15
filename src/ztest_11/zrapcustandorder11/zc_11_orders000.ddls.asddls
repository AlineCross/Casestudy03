@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: 'Orders'
}
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity ZC_11_ORDERS000
  as projection on ZC_11_ORDERS
  association [1..1] to ZC_11_ORDERS as _BaseEntity on $projection.Customer_Id = _BaseEntity.Customer_Id and $projection.OrderId = _BaseEntity.OrderId
{
  @EndUserText: {
    label: 'Bestellnummer', 
    quickInfo: 'Bestellnummer'
  }
  key OrderId,
    @EndUserText: {
    label: 'Kundennummer', 
    quickInfo: 'Kundennummer'
  }
  Customer_Id,
  OrderDate,
  @EndUserText: {
    label: 'Summe der Bestellung', 
    quickInfo: 'Summe der Bestellung'
  }
  @Semantics: {
    amount.currencyCode: 'CURRENCY'
  }
  OrderTotal,
  @EndUserText: {
    label: 'Rabatt', 
    quickInfo: 'Rabatt'
  }
  Discount,
  @EndUserText: {
    label: 'Bestellinformation', 
    quickInfo: 'Bestellinformation'
  }
  Info,
  @EndUserText: {
    label: 'Bestellstatus', 
    quickInfo: 'Bestellstatus'
  }
  Status,
  @EndUserText: {
    label: 'Währung', 
    quickInfo: 'Währungsschlüssel'
  }
  Currency,
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
  _customers : redirected to parent ZC_11_CUSTOM,
  _BaseEntity
}
