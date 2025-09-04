@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZCS09_CSVPOSTC'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_CS09_CSVPOSTC
  as select from zcs09_csvpostc
{
  key invoice as Invoice,
  comments as Comments,
   @Semantics.largeObject:
      { mimeType: 'MimeType',
      fileName: 'Filename',
      contentDispositionPreference: #INLINE }
  attachment as Attachment,
  @Semantics.mimeType: true
  mimetype as Mimetype,
  filename as Filename,
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
