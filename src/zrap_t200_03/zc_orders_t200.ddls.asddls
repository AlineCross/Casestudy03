@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'p'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity zc_orders_t200 as select from ZR_orders_t200
{
    key OrderId,
    CustomerId,
    OrderDate,
     @Semantics.amount.currencyCode: 'currency'
    OrderTotal,
    Discount,
    Info,
    Status,
    Currency,
    LocalCreatedBy,
    LocalCreatedAt,
    LocalLastChangedBy,
    LocalLastChangedAt,
    LastChangedAt
}
