using DataEagleUserDataService as service from '../../srv/dataeagle-appvariant-c-userdata-service';

annotate DataEagleUserDataService.Variant with @(UI : {
    SelectionFields : [variantUserDataID, appID],
    LineItem        : [
        { $Type : 'UI.DataField', Value : variantUserDataID },
        { $Type : 'UI.DataField', Value : appID },
        { $Type : 'UI.DataField', Value : appVersion }
    ],
    HeaderInfo          : {
        TypeName       : 'Variant Details',
        TypeNamePlural : 'Variant User Data',
        TypeImageUrl   : 'sap-icon://information',
        Title          : { Value : variantUserDataID, ![@UI.Hidden] },
        //Description    : { Value : variantUserDataID, ![@UI.Hidden] }
    },
        HeaderFacets : [
        { $Type  : 'UI.ReferenceFacet', Target : '@UI.FieldGroup#HeaderGeneralInformation' },
    ],
    FieldGroup #HeaderGeneralInformation : {
        $Type : 'UI.FieldGroupType',
        Data  : [
            { Value : variantUserDataID },
            { Value : variantID },
            { Value : appID },
            { Value : appVersion }
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
    /*{
        $Type  : 'UI.CollectionFacet',
        Label  : 'Variant Config',
        ID     : 'VariantConfigFacet',
        Facets : [
        {
            $Type  : 'UI.ReferenceFacet',
            ID     : 'VariantConfigFacet',
            Target : '@UI.FieldGroup#VariantConfig'
        }
        ]
    },*/
            //{ 
            //$Type: 'UI.ReferenceFacet', 
            //Label: 'Variant Config', 
            //Target: 'VariantUserData'
        //},
    ],
    FieldGroup #VariantDetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
            { $Type : 'UI.DataField', Value : variantID },
            { $Type : 'UI.DataField', Value : variantPurpose },
            { $Type : 'UI.DataField', Value : appID },
            { $Type : 'UI.DataField', Value : appVersion }     
       ]
    },
        FieldGroup #VariantConfig : {
        $Type : 'UI.FieldGroupType',
        Data : [
            //{ $Type : 'UI.DataField', Value : variant.variantConfig.variantParamID },
            //{ $Type : 'UI.DataField', Value : variantConfigObj.variantParamID },
            //{ $Type : 'UI.DataField', Value : variantConfigObj.variantParamType },  
            //{ $Type : 'UI.DataField', Value : variantParamValue },       
       ]
    }
});
/*
annotate DataEagleUserDataService.VariantUserData with @(UI : {
    SelectionFields : [variant.appID],
    LineItem        : [
        { $Type : 'UI.DataField', Value : variantUserDataID },
        { $Type : 'UI.DataField', Value : variant.appID },
        { $Type : 'UI.DataField', Value : variant.appVersion },
        { $Type : 'UI.DataField', Value : createdAt },
        { $Type : 'UI.DataField', Value : createdBy }
    ],
    HeaderInfo          : {
        TypeName       : 'Variant Details',
        TypeNamePlural : 'Variant User Data',
        TypeImageUrl   : 'sap-icon://information',
        Title          : { Value : variantUserDataID, ![@UI.Hidden] },
        Description    : { Value : variantUserDataID, ![@UI.Hidden] }
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
        $Type  : 'UI.CollectionFacet',
        Label  : 'Variant Config',
        ID     : 'VariantConfigFacet',
        Facets : [
        {
            $Type  : 'UI.ReferenceFacet',
            ID     : 'VariantConfigFacet',
            Target : '@UI.FieldGroup#VariantConfig'
        }
        ]
    },
    ],
    FieldGroup #VariantDetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
            { $Type : 'UI.DataField', Value : variantUserDataID },
            { $Type : 'UI.DataField', Value : variant.appID},
            { $Type : 'UI.DataField', Value : variant.appVersion },      
       ]
    },
        FieldGroup #VariantConfig : {
        $Type : 'UI.FieldGroupType',
        Data : [
            //{ $Type : 'UI.DataField', Value : variant.variantConfig.variantParamID },
            //{ $Type : 'UI.DataField', Value : variantConfigObj.variantParamID },
            //{ $Type : 'UI.DataField', Value : variantConfigObj.variantParamType },  
            { $Type : 'UI.DataField', Value : variantParamValue },       
       ]
    }
});
*/
