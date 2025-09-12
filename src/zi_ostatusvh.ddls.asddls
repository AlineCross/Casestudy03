@AbapCatalog.viewEnhancementCategory: [#NONE]
@Consumption.valueHelpDefault.fetchValues: #AUTOMATICALLY_WHEN_DISPLAYED
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help CDS für Customerorders Status'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_OSTATUSVH as select from zcs03_ostatus_vh
{   
    key status as Status,
    @UI.hidden: true
    key language as Language,
    status_description as StatusDescription

}

where language = $session.system_language
