@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZCS09_POSTCODES'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_CS09_POSTCODES
  as select from zcs09_postcodes
{
  key postcode as Postcode,
//  @Aggregation.referenceElement: ['Postcode']
//@Aggregation.default: #COUNT_DISTINCT
//cast( 1 as abap.int4 ) as DistinctPstCds,
  city as City,
  district as District,
  @Semantics.user.createdBy: true
  local_created_by as LocalCreatedBy,
  @Semantics.systemDateTime.createdAt: true
  local_created_at as LocalCreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  local_last_changed_by as LocalLastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt
}
