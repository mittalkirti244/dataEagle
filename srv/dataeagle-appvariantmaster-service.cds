using {com.hcl.dataeagle.appvariant.db as my} from '../db/appvariantmaster';

service DataEagleVariantService @(path:'/dataeagle/appvariantmaster'){

    entity VariantMaster as projection on my.VariantMaster
    actions {
        //@sap.applicable.path: 'activeEnabled'
        action activate();
        //@sap.applicable.path: 'deactiveEnabled'
        action deactivate();
        action cancel();
    };

    entity VariantConfig as projection on my.VariantConfig;
    entity VariantParamTypes as projection on my.VariantParamTypes;
}

/*
annotate DataEagleVariantService.VariantMaster with @(UI : {
    SelectionFields : [variantID],
    LineItem        : [
        { $Type : 'UI.DataField', Value : variantID },
        { $Type : 'UI.DataField', Value : appID},
        { $Type : 'UI.DataField', Value : appVersion },
        { $Type : 'UI.DataField', Value : createdAt },
        { $Type : 'UI.DataField', Value : createdBy }
    ]
});
*/
