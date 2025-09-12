@AbapCatalog.viewEnhancementCategory: [#PROJECTION_LIST]
@AbapCatalog.extensibility.dataSources: [ 'Customers' ]
@AbapCatalog.extensibility.elementSuffix: 'ZVP'
@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: 'Kundendaten'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZCS03_CUSTOMERS000'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_CS03_CUSTOMERS000
  provider contract transactional_query
  as projection on ZR_CS03_CUSTOMERS000 as Customers
  association [1..1] to ZR_CS03_CUSTOMERS000 as _BaseEntity on $projection.CustomerID = _BaseEntity.CustomerID
{

  key CustomerID,
      Salutation,
      LastName,
      FirstName,
      Company,
      Street,
      City,
      @Consumption: {
      valueHelpDefinition: [ {
      entity.element: 'Country',
      entity.name: 'I_CountryVH',
      useForValidation: true
      } ]
      }
      Country,
      //    @Consumption: {
      //    valueHelpDefinition: [ {
      //      entity.element: 'Postcode',
      //      entity.name: 'I_PostcodeVH',
      //      useForValidation: true
      //    } ]
      //  }
      Postcode,
      AccLock,
      @Semantics: {
        amount.currencyCode: 'Currency'
      }
      SalesVolume,
     
      @Consumption: {
        valueHelpDefinition: [ {
          entity.element: 'Currency',
          entity.name: 'I_CurrencyStdVH',
          useForValidation: true
        } ]
      }
      Currency,
      @Semantics: {
        amount.currencyCode: 'CurrencyTarget'
      }
      SalesVolumeTarget,
      @Consumption: {
        valueHelpDefinition: [ {
          entity.element: 'Currency',
          entity.name: 'I_CurrencyStdVH',
          useForValidation: true
        } ]
      }
      CurrencyTarget,
      ChangeRateDate,
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_CS03_NUM_ORDERS'
      @EndUserText.label: 'Anzahl der Bestellungen'
      virtual number_of_orders : abap.int8,
      Fax,
      Phone,
      Email,
      Url,
      @Consumption: {
      valueHelpDefinition: [ {
      entity.element: 'Language',
      entity.name: 'I_LanguageVH',
      useForValidation: true
      } ]
      }
      Language,
      WebLogin,
      WebPwd,
      Memo,
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
