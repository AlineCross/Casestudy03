@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS View für die Umsätze von Tabelle Custorders'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
//CDS View mit Parameter für die Anzeige der Umsätze eines Kunden
define view entity ZCS03custorders_r
with parameters pa_customer_id : zcustomer_id03
as select from zcs03_custorders
association [0..1] to zcs03customers_r as _Customers
on $projection.CustomerId = _Customers.CustomerId
{
    key order_id as OrderId,
    customer_id as CustomerId,
    order_date as OrderDate,
    @Semantics.amount.currencyCode: 'Currency'
    order_total as OrderTotal,
    discount as Discount,
    info as Info,
    status as Status,
    currency as Currency,
    local_created_by as LocalCreatedBy,
    local_created_at as LocalCreatedAt,
    local_last_changed_by as LocalLastChangedBy,
    local_last_changed_at as LocalLastChangedAt,
    last_changed_at as LastChangedAt,
    _Customers
}
where customer_id = $parameters.pa_customer_id
