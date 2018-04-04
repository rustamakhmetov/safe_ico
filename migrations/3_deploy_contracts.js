var MainICO = artifacts.require("MainICO");
var MyERC20Token9 = artifacts.require("MyERC20Token9");

module.exports = function(deployer) {
    deployer.deploy(MainICO, MyERC20Token9.address);
};