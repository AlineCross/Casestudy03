@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZCS03_OSTATUS_VH'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_CS03_OSTATUS_VH
  provider contract transactional_query
  as projection on ZR_CS03_OSTATUS_VH
  association [1..1] to ZR_CS03_OSTATUS_VH as _BaseEntity on $projection.Status = _BaseEntity.Status and $projection.Language = _BaseEntity.Language
{
  key Status,
  key Language,
  StatusDescription,
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
