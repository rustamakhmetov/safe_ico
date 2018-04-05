const Stage1ICO = artifacts.require('Stage1ICO');

contract('StageICO', function(accounts) {

    it('isName', async function () {
        let stage_ico = await Stage1ICO.new(0x0);
        let is_name = await stage_ico.isName('Stage1ICO');
        assert.isTrue(is_name, 'stage name should be Stage1ICO');
    });
});