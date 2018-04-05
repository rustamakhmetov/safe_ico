const Reverter = require('./helpers/reverter');
const MainICO = artifacts.require('MainICO');
const Token = artifacts.require('MyERC20Token9');

contract('[MainICO] buy tokens', function(accounts) {
    const reverter = new Reverter(web3);
    afterEach('revert', reverter.revert);

    let main_ico;
    let token;

    before('setup', () => {
        Token.deployed()
            .then(instance => token = instance);
        return MainICO.deployed()
            .then(instance => main_ico = instance)
            .then(reverter.snapshot);
    });

    it('buy tokens', async function() {
        let account = web3.eth.accounts[0];
        let stage = await main_ico.stage();
        assert.equal(stage, "Stage1ICO", "stage should be 'Stage1ICO'");

        let account_balance = (await token.balanceOf(account)).toNumber();
        assert.equal(account_balance, 0, 'account balance should be 0');

        let result = await main_ico.sendTransaction({ from: account, gas: 3000000, value: web3.toWei(0.001, "ether")});
        account_balance = (await token.balanceOf(account)).toNumber();
        assert.equal(account_balance, 1000000000000000000, 'account balance should be 1 token (with considering decimals)');
    });
});