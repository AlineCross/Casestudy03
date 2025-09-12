@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Convert Sales into target currency'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZR_CS03_CUST_CONV_SALES with parameters
pa_customer_id: zcustomer_id03,
    @Environment.systemField: #SYSTEM_DATE
    pa_date        : abap.dats,
    pa_currency_target : /dmo/currency_code,
    pa_currency : /dmo/currency_code
as select from ZR_CS03_CUST_SALES_VOL( pa_customer_id: $parameters.pa_customer_id )
{
    key CustomerID,
    @Semantics.amount.currencyCode: 'Currency'
    SalesVolume,
    $parameters.pa_currency as Currency,
    @Semantics.amount.currencyCode: 'TargetCurrency'
    currency_conversion(
    amount => SalesVolume,
    source_currency => $parameters.pa_currency,
    target_currency => $parameters.pa_currency_target,
    exchange_rate_date => $parameters.pa_date
                     ) as SalesVolumeTarget,
    $parameters.pa_currency_target as TargetCurrency
}
