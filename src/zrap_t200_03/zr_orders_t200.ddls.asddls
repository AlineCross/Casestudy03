@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'view orders child'
@Metadata.ignorePropagatedAnnotations: false
define root view entity ZR_orders_t200
  as select from zt200_custorders
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
    // Make association public
}
