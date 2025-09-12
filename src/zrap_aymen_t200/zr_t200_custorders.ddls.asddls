@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZT200_CUSTORDERS'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_T200_CUSTORDERS
  as select from ZT200_CUSTORDERS
{
  key order_id as OrderID,
  customer_id as CustomerID,
  order_date as OrderDate,
  @Semantics.amount.currencyCode: 'Currency'
  order_total as OrderTotal,
  discount as Discount,
  info as Info,
  status as Status,
  @Consumption.valueHelpDefinition: [ {
    entity.name: 'I_CurrencyStdVH', 
    entity.element: 'Currency', 
    useForValidation: true
  } ]
  currency as Currency,
  @Semantics.user.createdBy: true
  local_created_by as LocalCreatedBy,
  @Semantics.systemDateTime.createdAt: true
  local_created_at as LocalCreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  local_last_changed_by as LocalLastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt
}
