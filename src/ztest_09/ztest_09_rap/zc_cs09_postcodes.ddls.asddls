@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZCS09_POSTCODES'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_CS09_POSTCODES
  provider contract transactional_query
  as projection on ZR_CS09_POSTCODES
  association [1..1] to ZR_CS09_POSTCODES as _BaseEntity on $projection.Postcode = _BaseEntity.Postcode
{
  key Postcode,
  @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_CS09_POSTCODES'
  virtual DistinctPstCds : abap.int8,
  City,
  District,
  @Semantics: {
    user.createdBy: true
  }
  LocalCreatedBy,
  @Semantics: {
    systemDateTime.createdAt: true
  }
  LocalCreatedAt,
  @Semantics: {
    user.localInstanceLastChangedBy: true
  }
  LocalLastChangedBy,
  @Semantics: {
    systemDateTime.localInstanceLastChangedAt: true
  }
  LocalLastChangedAt,
  @Semantics: {
    systemDateTime.lastChangedAt: true
  }
  LastChangedAt,
  _BaseEntity
}
