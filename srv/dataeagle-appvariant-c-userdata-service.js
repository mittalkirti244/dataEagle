const cds = require('@sap/cds')

module.exports = cds.service.impl(async function () {
    const { VariantUserData } = this.entities

    this.on('getVariantPersonalization', async (req) => {
        console.log("req.data value =", req.data)
        var vvariantUserID, vappID, params, vtemp1, vtemp2, vselectedfilter, response, tx
        var selectedParams = []
        var vfilterArray = []
        
        vvariantUserID = req.data.variantUserID
        vappID = req.data.appID

        tx = cds.transaction(req)
        response = await tx.read(VariantUserData).where({ variantUserDataID: vvariantUserID }).and({ appID: vappID })
        console.log("response value =", response)
        for (let each of response) {
            params = {
                vvParamID: each.variantParamID,
                vvParamValue: each.variantParamValue
            }
            selectedParams.push(params)
        }
        console.log("selectedParams value =", selectedParams)

        for (let i = 0; i < selectedParams.length; i++) {
            vselectedfilter = selectedParams[i].vvParamID + " eq " + "'" + selectedParams[i].vvParamValue + "'"
            console.log('vselectedfilter value = ', vselectedfilter)
            vfilterArray.push(vselectedfilter);
        }
        console.log("varray value = ", vfilterArray)

        for (let j = 0; j < vfilterArray.length; j++) {
            console.log("vfilterArray[j] value =", vfilterArray[j])
            if (j == 0) {
                vtemp1 = vfilterArray[j];
                vtemp2 = vtemp1
                console.log("temp1 value in j=0=", vtemp1)
                console.log("temp2 value in j=0=", vtemp2)
            } else {
                console.log("temp2 value =", vtemp2)
                vtemp1 = vtemp2 + ' and ' + vfilterArray[j]
                vtemp2 = vtemp1
                console.log("temp1 value =", vtemp1)
                console.log("temp2 value =", vtemp2)
            }
        }
        return vtemp2
    })
});
