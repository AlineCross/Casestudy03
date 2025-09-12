@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'view cus parent'
@Metadata.ignorePropagatedAnnotations: false

define root view entity ZR_customers_t200
  as select from zt200_customers
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
    last_date as LastDate,
    sales_volume as SalesVolume,
    currency as Currency,
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
    last_changed_at as LastChangedAt,
    zzvip_zvp as ZzvipZvp
}
