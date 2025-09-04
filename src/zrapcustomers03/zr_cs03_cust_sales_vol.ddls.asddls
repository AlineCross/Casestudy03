@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Total Volume for CustomerSales'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZR_CS03_CUST_SALES_VOL with parameters
        pa_customer_id : zcustomer_id03 as select from ZR_CS03_CUSTOMERS000 as c
        right outer join zcs03_custorders as o
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
    c.Currency
