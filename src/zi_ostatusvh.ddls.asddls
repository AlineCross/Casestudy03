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
// Value Help für das Feld Satus in der Tabelle ZCS03_CUSTOMERORDERS unter Einbeziehung der System-Sprache
define view entity ZI_OSTATUSVH as select from zcs03_ostatus_vh
{   
    @UI.textArrangement: #TEXT_ONLY
    @ObjectModel.text.element: ['StatusDescription']
    key status as Status,
    @UI.hidden: true
    key language as Language,
    status_description as StatusDescription

}

where language = $session.system_language
