namespace com.hcl.dataeagle.appvariant.db;

using { managed, sap.common } from '@sap/cds/common';

entity VariantMaster : managed {
    key ID                      : UUID      @title : 'ID'  @Core.Computed;
        variantID               : String(32)@title : 'Variant ID';
        variantPurpose          : String    @title : 'Description';
        appID                   : String    @title : 'Application ID'; //Variant applicable for Application ID
        appVersion              : String    @title : 'Application Version'; // Variant applicable for Application Version
        variantStatus           : String    @title : 'Variant Status'
        enum {
            CREATED;
            ACTIVE;
            DEACTIVATED;
            CANCELLED;
        };
        virtual activeEnabled   : Boolean;
        virtual deactiveEnabled : Boolean;
        tenantID                : String    @title : 'Tenant ID';
        managedByUser           : String    @title : 'Managed By User'; //userID for data authentication purpose. Manual entry by user
        //variantConfig  : Association to many VariantConfig on variantConfig.variant = $self;
        variantConfig           : Composition of many VariantConfig
                                      on variantConfig.variant = $self;
}

entity VariantConfig : managed {
    key ID              : UUID      @title : 'ID'  @Core.Computed;
        variantConfigID : String(32)@title : 'Variant Configuration ID';
        variantParamID  : String(32)@title : 'Parameter ID';
        managedByUser   : String    @title : 'Managed By User'; //userID for data authentication purpose. Manual entry by user
        variant         : Association to VariantMaster;
        paramType       : Association to one VariantParamTypes;
}

@cds.odata.valuelist
entity VariantParamTypes {
    key paramDataType : String @title : 'Parameter Type'  @readonly;
}
