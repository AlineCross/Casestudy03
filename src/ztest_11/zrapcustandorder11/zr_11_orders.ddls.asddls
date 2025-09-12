@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@EndUserText.label: 'Orders'
define root view entity ZR_11_ORDERS as select from zcs03_custorders
{
    key order_id as OrderId,
    customer_id as CustomerId,
    order_date as OrderDate,
    order_total as OrderTotal,
    discount as Discount,
    info as Info,
    status as Status,
    currency as Currency,
    local_created_by as LocalCreatedBy,
    local_created_at as LocalCreatedAt,
    local_last_changed_by as LocalLastChangedBy,
    local_last_changed_at as LocalLastChangedAt,
    last_changed_at as LastChangedAt
}
