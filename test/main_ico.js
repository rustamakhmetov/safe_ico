const Reverter = require('./helpers/reverter');
const Asserts = require('./helpers/asserts');
const MainICO = artifacts.require('MainICO');

contract('MainICO', function(accounts) {
    const reverter = new Reverter(web3);
    afterEach('revert', reverter.revert);

    let main_ico;

    // before('setup', async () => {
    //     main_ico = await MainICO.deployed();
    //     await reverter.snapshot;
    // });

    before('setup', () => {
        return MainICO.deployed()
            .then(instance => main_ico = instance)
            .then(reverter.snapshot);
    });


    it('sets the first account as the contract creator', async function() {
        const creator = await main_ico.owner();
        assert.equal(creator, accounts[0], 'main account is the creator')
    });

    it('has increase time', async function() {
        let start_time = await main_ico.getCurrentTime.call();
        start_time = start_time.toNumber();
        await reverter.timeTravel(10); // 10 sec
        let current_time = await main_ico.getCurrentTime.call();
        assert.equal(current_time.toNumber(), start_time+10, "current time should be change");
    });

    // it('has hello world as initial message ', async function() {
    //     const contract = await HelloWorld.deployed()
    //     const message = await contract.getMessage()
    //
    //     assert.equal(message, 'hello world', 'message is hello world')
    // })
    // it('changes the message via setMessage', async function() {
    //     const contract = await HelloWorld.deployed()
    //
    //     // Execute a transaction and change the state of the contract.
    //     await contract.setMessage('hola mundo')
    //
    //     // Get the new state.
    //     const message = await contract.getMessage()
    //
    //     assert.equal(message, 'hola mundo', 'message is hola mundo')
    // })

    //===================================================================

});