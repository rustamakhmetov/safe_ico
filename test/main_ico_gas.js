const Reverter = require('./helpers/reverter');
const Asserts = require('./helpers/asserts');
const MainICO = artifacts.require('MainICO');
const Token = artifacts.require('MyERC20Token9');

contract('MainICO gas', function(accounts) {
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


    // it('change stages', async function() {
    //     let stage1 = await main_ico.stage();
    //     let gas = await main_ico.stage.estimateGas.call(1);
    //     console.log("Step 1. stage", stage1, ",gas:", gas);
    //
    //     stage1 = await main_ico.stage();
    //     gas = await main_ico.stage.estimateGas.call(1);
    //     console.log("Step 1. stage", stage1, ",gas:", gas);
    //
    //     //let stage = await main_ico.stage.call();
    //
    //     // console.log("stage gas:", gas);
    //     // let buy_price = (await main_ico.buy_price.call()).toNumber();
    //     // assert.equal(stage, "Stage1ICO", "stage should be 'Stage1ICO'");
    //     // assert.equal(buy_price, web3.toWei(0.001, "ether"), "buy price should be 10000");
    //
    //     // await reverter.timeTravel(121); // 2 min
    //     // stage = await main_ico.stage.call();
    //     // assert.equal(stage, "Stage2ICO", "stage should be 'Stage2ICO'");
    //     // buy_price = (await main_ico.buy_price.call()).toNumber();
    //     // assert.equal(buy_price, web3.toWei(0.01, "ether"), "buy price should be 20000");
    //     //
    //     // for (let i=0; i < 2; i++) {
    //     //     await reverter.timeTravel(120); // 2 min
    //     //     stage = await main_ico.stage.call();
    //     //     assert.equal(stage, "Stage3ICO", "stage should be 'Stage3ICO'");
    //     //     buy_price = (await main_ico.buy_price.call()).toNumber();
    //     //     assert.equal(buy_price, web3.toWei(0.1, "ether"), "buy price should be 40000");
    //     // }
    // });
});