@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Durchschnittsumsatz im Geschäftsjahr'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZR_CS03_CUST_SALES_AVERAGE 
with parameters
    pa_customer_id : zcustomer_id03,
    pa_fiscal_year : zgeschaeftshjahr03
as select from ZR_CS03_CUSTOMERS000 as c
right outer join zcs03_custorders as o
on c.CustomerID = o.customer_id
{
    key c.CustomerID,
    @Semantics.amount.currencyCode: 'Currency'
    avg( o.order_total  as abap.curr( 15, 2 ))  as AverageSales,
    c.Currency
    
}
where c.CustomerID = $parameters.pa_customer_id
and o.status = 'BB'
and  substring( o.order_date, 1, 4 ) = $parameters.pa_fiscal_year

group by 
    c.CustomerID,
    c.Currency
