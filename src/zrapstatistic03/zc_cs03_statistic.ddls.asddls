@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'ZCS03_STATISTIC'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_CS03_STATISTIC
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_CS03_STATISTIC
  association [1..1] to ZR_CS03_STATISTIC as _BaseEntity on $projection.INTERFACE = _BaseEntity.INTERFACE and $projection.CLASS = _BaseEntity.CLASS
{
  key Interface,
  key Class,
  Active,
  @Semantics: {
    User.Createdby: true
  }
  LocalCreatedBy,
  @Semantics: {
    Systemdatetime.Createdat: true
  }
  LocalCreatedAt,
  @Semantics: {
    User.Localinstancelastchangedby: true
  }
  LocalLastChangedBy,
  @Semantics: {
    Systemdatetime.Localinstancelastchangedat: true
  }
  LocalLastChangedAt,
  @Semantics: {
    Systemdatetime.Lastchangedat: true
  }
  LastChangedAt,
  _BaseEntity
}
