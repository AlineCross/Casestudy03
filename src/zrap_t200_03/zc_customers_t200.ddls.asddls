@EndUserText.label: 'Customer Consumption View'

define root view entity ZC_customers_t200  
  as select from ZR_customers_t200 
    association [0..*] to ZC_T200_CUSTORDERS as _Orders
      on $projection.CustomerId = _Orders.CustomerID
{
  key CustomerId,
  FirstName,
  LastName,
  Company,
  City,
  Country,
  @Semantics.amount.currencyCode: 'currency'
  SalesVolume,
  Currency,
  @Semantics.amount.currencyCode: 'CurrencyTarget'
  SalesVolumeTarget,
  CurrencyTarget,
  Phone,
  Email,
  Language,
  _Orders
  
} 
