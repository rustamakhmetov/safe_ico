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
    uint public startTime;
    address public owner;
    BaseICO[] stages = new BaseICO[](3);
    uint public current_stage;

    event Stage(uint _value);

    function MainICO(MyERC20Token8 _token){
        token = _token;
        startTime = now;
        stages[0] = new Stage1ICO(token);
        stages[1] = new Stage2ICO(token);
        stages[2] = new Stage3ICO(token);
        setStage(0);
        owner = msg.sender;
    }

    function remove() public {
        if (msg.sender == owner){
            selfdestruct(owner);
        }
    }

    function setStage(uint _value) internal {
        current_stage = _value;
    }

    function getStage() internal returns(BaseICO) {
        return stages[current_stage];
    }

    function getCurrentStage() public constant returns(uint) {
        return current_stage;
    }

    function nextStage() internal returns(BaseICO) {
        if (stages.length > current_stage + 1) {
            setStage(current_stage + 1);
        }
        return getStage();
    }

    function getStageName() public returns(string) {
        return bytes32ToString(getStage().name());
    }

    function _buy_price() internal returns(uint256) {
        Log("[Main ICO] _buy_price");
        return getContract().buyPrice();
    }

    function updateStage() public {
        if (current_stage<2 && now > startTime + 4 minutes){
            // третий этап
            nextStage();
        } else if (current_stage<1 && now > startTime + 2 minutes)	{
            // второй этап
            nextStage();
        }
    }

    function getContract() internal returns(BaseICO) {
        updateStage();
        Stage(current_stage);
        return getStage();
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
