@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'ZCS09_POSTCODES'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_CS09_POSTCODES
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_CS09_POSTCODES
  association [1..1] to ZR_CS09_POSTCODES as _BaseEntity on $projection.POSTCODE = _BaseEntity.POSTCODE
{
  key Postcode,
  City,
  District,
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
