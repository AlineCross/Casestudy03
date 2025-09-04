@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Total Volume for Cust_Sales'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZR_CS09_TotlVol
    with parameters
        pa_customer_id : zcustomer_id03 as select from ZR_CS09_CUSTOMERS as c
        right outer join zcs09_custorders as o
       on c.CustomerID = o.customer_id
{
    key c.CustomerID,
    @Semantics.amount.currencyCode: 'Currency'
    sum( o.order_total ) as SalesVolume,
    c.Currency
}
where c.CustomerID = $parameters.pa_customer_id

group by 
    c.CustomerID,
    c.SalesVolume,
    c.Currency
