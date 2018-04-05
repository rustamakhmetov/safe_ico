pragma solidity ^0.4.11;

import "./BaseICO.sol";
import "./Stage1ICO.sol";
import "./Stage2ICO.sol";
import "./Stage3ICO.sol";

//import "https://github.com/rustamakhmetov/safe_ico/contracts/BaseICO.sol";
//import "https://github.com/rustamakhmetov/safe_ico/contracts/Stage1ICO.sol";
//import "https://github.com/rustamakhmetov/safe_ico/contracts/Stage2ICO.sol";
//import "https://github.com/rustamakhmetov/safe_ico/contracts/Stage3ICO.sol";
//import "https://github.com/rustamakhmetov/safe_ico/contracts/MyERC20Token9.sol";

contract MainICO is BaseICO {
    BaseICO public _contract;
    uint public startTime;
    address public owner;
    //address public __base;

    function MainICO(MyERC20Token8 _token){
        token = _token;
        startTime = now;
        _contract = new Stage1ICO(token);
        owner = msg.sender;
    }

    // remove contract
    function remove() public {
        if (msg.sender == owner){
            selfdestruct(owner);
        }
    }

    function _buy_price() internal returns(uint256) {
        Log("[Main ICO] _buy_price");
        return getContract().buyPrice();
    }

    function getContract() internal returns(BaseICO) {
        if (now > startTime + 4 minutes){
            //третий	вариант
            if (!_contract.isName("Stage3ICO")) {
                _contract = new Stage3ICO(token);
            }
            emit Log("stage 3");
            return _contract;
        }
        if (now > startTime + 2 minutes)	{
            //	второй	вариант
            if  (!_contract.isName("Stage2ICO")) {
                _contract = new Stage2ICO(token);
            }
            Log("stage 2");
            return _contract;
        }
        // первый вариант
        Log("stage 1");
        return _contract;
    }

    function getTokenName() view returns(string) {
        bytes32 _name = token.getName();
        return bytes32ToString(_name);
    }

    function getCurrentTime() returns (uint){
        return now;
    }

    function _now() view public returns(uint) {
        return now;
    }

    function stage() view public returns(string) {
        return bytes32ToString(getContract().name());
    }

    function buy_price() view public returns(uint) {
        return _buy_price();
    }

}
