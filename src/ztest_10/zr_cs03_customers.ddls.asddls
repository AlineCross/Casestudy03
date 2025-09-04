@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZCS03_CUSTOMERS'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_CS03_CUSTOMERS
  as select from ZCS03_CUSTOMERS
{
  key customer_id as CustomerID,
  salutation as Salutation,
  last_name as LastName,
  first_name as FirstName,
  company as Company,
  street as Street,
  city as City,
  country as Country,
  postcode as Postcode,
  acc_lock as AccLock,
  @Semantics.amount.currencyCode: 'Currency'
  sales_volume as SalesVolume,
  @Consumption.valueHelpDefinition: [ {
    entity.name: 'I_CurrencyStdVH', 
    entity.element: 'Currency', 
    useForValidation: true
  } ]
  currency as Currency,
  @Semantics.amount.currencyCode: 'CurrencyTarget'
  sales_volume_target as SalesVolumeTarget,
  @Consumption.valueHelpDefinition: [ {
    entity.name: 'I_CurrencyStdVH', 
    entity.element: 'Currency', 
    useForValidation: true
  } ]
  currency_target as CurrencyTarget,
  change_rate_date as ChangeRateDate,
  fax as Fax,
  phone as Phone,
  email as Email,
  url as Url,
  language as Language,
  web_login as WebLogin,
  web_pwd as WebPwd,
  memo as Memo,
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
