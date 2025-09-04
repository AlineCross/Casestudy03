@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'ZCS03_CASESTUDY'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_CS03_CASESTUDY
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_CS03_CASESTUDY
  association [1..1] to ZR_CS03_CASESTUDY as _BaseEntity on $projection.UUID = _BaseEntity.UUID
{
  key UUID,
  Import,
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
