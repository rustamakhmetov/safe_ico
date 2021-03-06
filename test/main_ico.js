const Reverter = require('./helpers/reverter');
const Asserts = require('./helpers/asserts');
const MainICO = artifacts.require('MainICO');
const Token = artifacts.require('MyERC20Token9');

contract('MainICO', function(accounts) {
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


    it('sets the first account as the contract creator', async function() {
        const creator = await main_ico.owner();
        assert.equal(creator, accounts[0], 'main account is the creator')
    });

    it('get token name', async function() {
        let token_name = await main_ico.getTokenName.call();
        assert(token_name, token.name, 'token name should be '+token.name);
    });

    it('has increase time', async function() {
        let start_time = await main_ico.getCurrentTime.call();
        start_time = start_time.toNumber();
        await reverter.timeTravel(10); // 10 sec
        let current_time = await main_ico.getCurrentTime.call();
        assert.equal(current_time.toNumber(), start_time+10, "current time should be change");
    });

    it('change stages', async function() {
        let stage = await main_ico.stage();
        let buy_price = (await main_ico.buy_price()).toNumber();
        assert.equal(stage, "Stage1ICO", "stage should be 'Stage1ICO'");
        assert.equal(buy_price, web3.toWei(0.001, "ether"), "buy price should be 10000");

        await reverter.timeTravel(120); // 2 min
        await main_ico.updateStage();

        stage = await main_ico.stage();
        assert.equal(stage, "Stage2ICO", "stage should be 'Stage2ICO'");
        buy_price = (await main_ico.buy_price()).toNumber();
        assert.equal(buy_price, web3.toWei(0.01, "ether"), "buy price should be 20000");

        await reverter.timeTravel(150); // 2 min
        await main_ico.updateStage();

        for (let i=0; i < 2; i++) {
            await reverter.timeTravel(120); // 2 min
            await main_ico.updateStage();

            stage = await main_ico.stage();
            assert.equal(stage, "Stage3ICO", "stage should be 'Stage3ICO'");
            buy_price = (await main_ico.buy_price()).toNumber();
            assert.equal(buy_price, web3.toWei(0.1, "ether"), "buy price should be 40000");
        }
    });
});