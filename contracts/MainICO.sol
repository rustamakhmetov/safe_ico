pragma solidity ^0.4.0;

import "./BaseICO.sol";
import "./Stage1ICO.sol";
import "./Stage2ICO.sol";
import "./Stage3ICO.sol";

contract MainICO is BaseICO {
    BaseICO public _contract;
    uint public startTime;
    address public owner;

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
        if (now > startTime + 4 minutes){
            //третий	вариант
            if (!_contract.isName("Stage3ICO")) {
                _contract = new Stage3ICO(token);
            }
            return _contract.buyPrice();
        }
        if (now > startTime + 2 minutes)	{
            //	второй	вариант
            if  (!_contract.isName("Stage2ICO")) {
                _contract = new Stage2ICO(token);
            }
            return _contract.buyPrice();
        }
        // первый вариант
        return _contract.buyPrice();
    }

}
