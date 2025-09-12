@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'ZCS03_SETTINGS'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_CS03_SETTINGS
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_CS03_SETTINGS
  association [1..1] to ZR_CS03_SETTINGS as _BaseEntity on $projection.PARAM = _BaseEntity.PARAM
{
  key Param,
  Value,
  Description,
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
