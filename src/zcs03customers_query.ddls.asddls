@AbapCatalog.viewEnhancementCategory: [#PROJECTION_LIST]
@AbapCatalog.extensibility.dataSources: [ 'c' ]
@AbapCatalog.extensibility.elementSuffix: 'ZVP'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS für Umsätze Customers'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCS03customers_query
as select from zcs03customers_r as c
left outer join zcs03_custorders as o
on c.CustomerId = o.customer_id
{
    key c.CustomerId,
    c.Company,
    @Semantics.amount.currencyCode: 'Currency'
    sum( o.order_total )as SalesVolume,
    c.Currency,
    @Semantics.amount.currencyCode: 'Currency'
    max ( o.order_total )as SalesMax
}


group by
    c.Company,
    c.CustomerId,
    c.Currency
