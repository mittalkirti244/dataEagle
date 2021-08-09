using {com.hcl.dataeagle.appvariant.db as myvmaster} from '../db/appvariantmaster';
using {com.hcl.dataeagle.appvariant.db as myvuserdata} from '../db/appvariantuserdata';

extend myvmaster.VariantMaster with {
    //variantConfig   : Composition of many myvmaster.VariantConfig
    //                      on variantConfig.variant = $self;

    //variantUserData : Association to many myvuserdata.VariantUserData
    //                      on variantUserData.variant = $self;
    variantUserData  : Composition of many myvuserdata.VariantUserData
                             on variantUserData.variant = $self;
}

//extend myvmaster.VariantConfig with {
//    variant : Association to myvmaster.VariantMaster;
//}

extend myvuserdata.VariantUserData with {
    variant : Association to myvmaster.VariantMaster;
    variantConfigObj: Association to myvmaster.VariantConfig;
}

//extend myvuserdata.VariantUserDataMaster with {
//    variant : Association to myvmaster.VariantMaster;
//}