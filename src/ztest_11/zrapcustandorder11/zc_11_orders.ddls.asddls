@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@EndUserText.label: 'Orders'
//@ObjectModel.sapObjectNodeType.name: 'orders child'
define view entity ZC_11_ORDERS as select from zcs03_custorders
association to parent ZR_11_CUSTOM as _customers on 
$projection.Customer_Id = _customers.Customer_Id
{
    key order_id as OrderId,
    customer_id as Customer_Id,
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
    last_changed_at as LastChangedAt,
    
    _customers
}
