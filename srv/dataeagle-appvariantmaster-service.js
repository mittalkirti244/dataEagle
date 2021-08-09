const cds = require('@sap/cds')

module.exports = cds.service.impl(async function () {
    const { VariantMaster } = this.entities

    this.before('CREATE', 'VariantMaster', async (req) => {
        //console.log("req.data value = ", req.data)
        req.data.variantStatus = 'CREATED'
    })

    this.before('UPDATE', 'VariantMaster', async (req) => {
        console.log("req.params value = ", req.data)
        if (req.data.variantStatus == 'ACTIVE') {
            req.error(405, 'This variant cannot be changed as it is already in ACTIVE state.')
        }
    })

    /*this.before('DELETE', 'VariantMaster', async(req) => {
        console.log("req.data.variantStatus value = ", req.data.ID)
        var vvariantMaster = await SELECT.from(VariantMaster).columns('variantStatus').where({ID:req.data.ID})
        console.log('vvariantMaster value =', vvariantMaster)
        
    })*/

    /*this.after('READ', 'VariantMaster', (each) => {
        if (each.status_code === '1') {
            each.activeEnabled = true
        }
        if (each.status_code !== '3') {
            each.deactiveEnabled = true
        }
    })*/

    this.on('activate', async (req) => {
        var id, n
        var vvariant, vvariantID, vvariantStatus
        id = req.params[0]
        console.log('id value =', id)
        vvariant = await SELECT.from(VariantMaster).columns('variantID,variantStatus').where({ ID: id.ID })
        console.log("vvariant value = ", vvariant[0])
        vvariantID = vvariant[0].variantID
        vvariantStatus = vvariant[0].variantStatus
        if (vvariantStatus == 'CREATED' || vvariantStatus == 'DEACTIVATED' ) {
            n = await UPDATE(VariantMaster)
                .set({
                    variantStatus: 'ACTIVE'
                }).where({ ID: id.ID })
            console.log('n value =', n)
            n > 0 || req.error(404, 'The variant ' + vvariantID + ' cannot be deactivated as it is in ' + vvariantStatus.toLowerCase() + ' state.')
        } else if (vvariantStatus == 'CANCELLED' || vvariantStatus == 'ACTIVE') {
            req.error(404, 'The variant ' + vvariantID + ' cannot be deactivated as it is in ' + vvariantStatus.toLowerCase() + ' state.')
        }
    })

    this.on('deactivate', async (req) => {
        var id, n
        var vvariant, vvariantID, vvariantStatus
        id = req.params[0]
        console.log('id value =', id)
        vvariant = await SELECT.from(VariantMaster).columns('variantID,variantStatus').where({ ID: id.ID })
        console.log("vvariant value = ", vvariant[0])
        vvariantID = vvariant[0].variantID
        vvariantStatus = vvariant[0].variantStatus
        if (vvariantStatus == 'ACTIVE') {
            n = await UPDATE(VariantMaster)
                .set({
                    variantStatus: 'DEACTIVATED',
                }).where({ ID: id.ID })
            console.log('n value =', n)
            n > 0 || req.error(404, 'The variant ' + vvariantID + ' cannot be deactivated as it is in ' + vvariantStatus.toLowerCase() + ' state.')
        } else if (vvariantStatus == 'DEACTIVATED') {
            req.error(404, 'The variant ' + vvariantID + ' is alreay in deactivated state.')
        } else if (vvariantStatus == 'CREATED' || vvariantStatus == 'CANCELLED') {
            req.error(404, 'The variant ' + vvariantID + ' cannot be deactivated as it is in ' + vvariantStatus.toLowerCase() + ' state.')
        }
    })

    this.on('cancel', async (req) => {
        var id, n
        var vvariant, vvariantID, vvariantStatus
        id = req.params[0]
        console.log('id value =', id)
        vvariant = await SELECT.from(VariantMaster).columns('variantID,variantStatus').where({ ID: id.ID })
        console.log("vvariant value = ", vvariant[0])
        vvariantID = vvariant[0].variantID
        vvariantStatus = vvariant[0].variantStatus
        if (vvariantStatus == 'CREATED' || vvariantStatus == 'ACTIVE' || vvariantStatus == 'DEACTIVATED' ) {
            n = await UPDATE(VariantMaster)
                .set({
                    variantStatus: 'CANCELLED',
                }).where({ ID: id.ID })
            console.log('n value =', n)
            n > 0 || req.error(404, 'The variant ' + vvariantID + ' cannot be deactivated as it is in ' + vvariantStatus.toLowerCase() + ' state.')
        } else if (vvariantStatus == 'CANCELLED') {
            req.error(404, 'The variant ' + vvariantID + ' cannot be deactivated as it is already in ' + vvariantStatus.toLowerCase() + ' state.')
        }
    })

})