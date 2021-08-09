using {com.hcl.dataeagle.appvariant.db as mycuserdata} from '../db/appvariant-c-userdata';
using {com.hcl.dataeagle.appvariant.db as myvmaster} from '../db/appvariantmaster';

service DataEagleUserDataService @(path:'/dataeagle/appvariantuserdata'){

    @Capabilities : { UpdateRestrictions.Updatable: true }
    @Capabilities : { DeleteRestrictions.Deletable: false }
    entity VariantUserData as projection on mycuserdata.VariantUserData{
        *,
        variant.appID as appID,
        variant.variantStatus as variantStatus,
        variantConfigObj.variantConfigID as variantConfigID,
        variantConfigObj.variantParamID as variantParamID,
        variantConfigObj.paramType.paramDataType as variantParamType
    };
    entity VariantMaster as projection on mycuserdata.VariantMaster;
    entity variantConfig as projection on mycuserdata.VariantConfig;


    entity Variant as select from mycuserdata.VariantUserData as a, mycuserdata.VariantMaster as b{
        key a.variantUserDataID,
        key b.appID,
        a.variantID, 

        b.appVersion,
        b.variantPurpose
        //a.variantConfigID
        //count(a.variantConfigID) as variantConfigCount
    } where a.variantID = b.variantID 
      group by 
        a.variantUserDataID,
        a.variantID, 
        b.appID,
        b.appVersion,
        b.variantPurpose ;

    /*entity VariantUserData as select from mycuserdata.VariantUserData;
    entity Variant as select from VariantUserData distinct { 
        key variantID, 
        key variantUserDataID,
        //variantConfigID,
        //variantConfigParamID,
        //variantConfigParamType,
        //variantParamValue,
        //tenantID,
        //managedByUser        
    };*/

} 

/*
annotate DataEagleUserDataService.Variant with @(UI : {
    SelectionFields : [],
    LineItem        : [
        { $Type : 'UI.DataField', Value : variantUserDataID },
        { $Type : 'UI.DataField', Value : appID },
        { $Type : 'UI.DataField', Value : appVersion },
        //{ $Type : 'UI.DataField', Value : variantParamID },
        //{ $Type : 'UI.DataField', Value : variantParamType },
        //{ $Type : 'UI.DataField', Value : variantParamValue },
        //{ $Type : 'UI.DataField', Value : createdAt },
        //{ $Type : 'UI.DataField', Value : createdBy }
    ],
    /*
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
            { 
            $Type: 'UI.ReferenceFacet', 
            Label: 'Variant Config', 
            Target: 'variant/variantConfig/@UI.LineItem'
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
});*/

