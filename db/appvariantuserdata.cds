namespace com.hcl.dataeagle.appvariant.db;

using {managed} from '@sap/cds/common';

entity VariantUserData : managed {
    key ID                     : UUID      @title : 'ID'  @Core.Computed;
        variantUserDataID      : String(32)@title : 'Variant User Data ID';
        variantID              : String(32)@title : 'Variant ID';
        variantConfigID        : String(32)@title : 'Variant Config ID';
        variantConfigParamID   : String(32)@title : 'Parameter ID';
        variantConfigParamType : String    @title : 'Parameter Type';
        variantParamValue      : String    @title : 'Parameter Value';
        tenantID               : String    @title : 'Tenant ID';
        managedByUser          : String    @title : 'Managed By User'; //userID for data authentication purpose. Manual entry by user

}


