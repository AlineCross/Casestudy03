@AbapCatalog.viewEnhancementCategory: [#PROJECTION_LIST]
@AbapCatalog.extensibility.dataSources: [ 'Customers' ]
@AbapCatalog.extensibility.elementSuffix: 'ZVP'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root CDS für Customers'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zcs03customers_r as select from zcs03_customers as Customers

{
    key customer_id as CustomerId,
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
    currency as Currency,
    @Semantics.amount.currencyCode: 'CurrencyTarget'
    sales_volume_target as SalesVolumeTarget,
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
    local_created_by as LocalCreatedBy,
    local_created_at as LocalCreatedAt,
    local_last_changed_by as LocalLastChangedBy,
    local_last_changed_at as LocalLastChangedAt,
    last_changed_at as LastChangedAt
}
