var MainICO = artifacts.require("MainICO");
var MyERC20Token8 = artifacts.require("MyERC20Token8");

module.exports = function(deployer) {
    deployer.deploy(MainICO, MyERC20Token8.address);
};