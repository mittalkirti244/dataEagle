using DataEagleUserDataService as service from '../../srv/dataeagle-appvariant-c-userdata-service';

@odata.draft.enabled
annotate DataEagleVariantService.VariantMaster with @(UI : {
    SelectionFields : [variantID, managedByUser, variantStatus],
    LineItem        : [
        { $Type  : 'UI.DataFieldForAction', Action : 'DataEagleVariantService.activate', Label  : 'Activate', },
        { $Type  : 'UI.DataFieldForAction', Action : 'DataEagleVariantService.deactivate', Label  : 'Deactivate' },
        { $Type  : 'UI.DataFieldForAction', Action : 'DataEagleVariantService.cancel', Label  : 'Cancel' },
        { $Type : 'UI.DataField', Value : variantID },
        { $Type : 'UI.DataField', Value : variantPurpose },
        { $Type : 'UI.DataField', Value : appID },
        { $Type : 'UI.DataField', Value : appVersion },
        { $Type : 'UI.DataField', Value : variantStatus },
        { $Type : 'UI.DataField', Value : managedByUser },
        { $Type : 'UI.DataField', Value : createdAt },
        { $Type : 'UI.DataField', Value : createdBy }

    ],
    
    HeaderInfo          : {
        TypeName       : 'Variant Details',
        TypeNamePlural : 'Variant List',
        TypeImageUrl   : 'sap-icon://information',
        Title          : { Value : variantID  },
        Description    : { Value : variantStatus, ![@UI.Hidden] }
    },
    HeaderFacets : [
        { $Type  : 'UI.ReferenceFacet', Target : '@UI.FieldGroup#HeaderGeneralInformation' },
        { $Type  : 'UI.ReferenceFacet', Target : '@UI.FieldGroup#HeaderCreationInformation' },
        { $Type  : 'UI.ReferenceFacet', Target : '@UI.FieldGroup#HeaderModificationInformation' },
    ],
    FieldGroup #HeaderGeneralInformation : {
        $Type : 'UI.FieldGroupType',
        Data  : [
            { Value : variantPurpose },
            { Value : variantStatus }
        ]
    },
    FieldGroup #HeaderCreationInformation : {
        $Type : 'UI.FieldGroupType',
        Data  : [
            { Value : createdAt },
            { Value : createdBy },
        ]
    },
    FieldGroup #HeaderModificationInformation : {
        $Type : 'UI.FieldGroupType',
        Data  : [
            { Value : modifiedAt, Label: 'Modified On' },
            { Value : modifiedBy, Label: 'Modified By' },
        ]
    },
    Facets : [
        {
            $Type  : 'UI.CollectionFacet',
            Label  : 'Variant Details',
            ID     : 'VariantDetailsFacet',
            Facets : [
                {
                    $Type  : 'UI.ReferenceFacet',
                    ID     : 'VariantDetailsFacet',
                    Target : '@UI.FieldGroup#VariantDetails'
                }
            ]
        },
        { 
            $Type: 'UI.ReferenceFacet', 
            Label: 'Variant Config', 
            Target: 'variantConfig/@UI.LineItem' 
        }
    ],
    FieldGroup #VariantDetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
            { $Type : 'UI.DataField', Value : variantID },
            { $Type : 'UI.DataField', Value : variantPurpose },
            { $Type : 'UI.DataField', Value : appID },
            { $Type : 'UI.DataField', Value : appVersion },
            { $Type : 'UI.DataField', Value : managedByUser },         
       ]
    },
});

annotate DataEagleVariantService.VariantMaster with {
    variantID     @mandatory;
    appID         @mandatory;
    appVersion    @mandatory;
    managedByUser @mandatory;
}

annotate DataEagleVariantService.VariantConfig with @(UI : {
    LineItem       : [
        {Value : variantConfigID},
        {Value : variantParamID},
        {Value : paramType_paramDataType},
        {Value : createdAt},
        {Value : createdBy}
    ],
    Identification : [
        {Value : variantConfigID},
        {Value : createdAt},
    ],
    Facets         : [{
        $Type  : 'UI.ReferenceFacet',
        Label  : 'Variant Config',
        Target : '@UI.Identification'
    }, ],
});

annotate DataEagleVariantService.VariantConfig with {
    paramType @title: 'Parameter Type';
    paramType @Common :{
        Text: paramType.paramDataType,
        TextArrangement: #TextOnly,
        ValueListWithFixedValues
    } 
}


