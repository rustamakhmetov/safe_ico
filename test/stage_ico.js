const Stage1ICO = artifacts.require('Stage1ICO');

contract('StageICO', function(accounts) {

    it('isName', async function () {
        let stage_ico = await Stage1ICO.new(0x0);
        let is_name = await stage_ico.isName.call('Stage1ICO');
        // let gas = await stage_ico.isName.estimateGas(1);
        // console.log("isName gas:", gas);
        assert.isTrue(is_name, 'stage name should be Stage1ICO');
    });
});