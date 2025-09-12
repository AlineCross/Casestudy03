@EndUserText.label: 'Customer Consumption View'
@UI.headerInfo: {
  typeName: 'Customer',
  typeNamePlural: 'Customers',
  title: { value: 'last_name' },
  description: { value: 'first_name' }
}
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true

define view entity ZC_T200_Customers
  as select from zt200_customers
    association [0..*] to ZC_T200_CUSTORDERS as _Orders
      on $projection.customer_id = _Orders.CustomerID
{
  key customer_id,

  salutation,
  last_name,
  first_name,
  company,
  city,
  country,

  @Semantics.amount.currencyCode: 'currency'
  sales_volume,
  currency,

  @Semantics.amount.currencyCode: 'currency_target'
  sales_volume_target,
  currency_target,

  phone,
  email,
  language,

  _Orders
}
