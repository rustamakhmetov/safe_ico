pragma solidity ^0.4.11;

import "./BaseICO.sol";

contract Stage2ICO is BaseICO {
    function Stage2ICO(MyERC20Token8 _token){
        token = _token;
        buyPrice = 20000;
    }

    function name() public view returns(bytes32) {
        return "Stage2ICO";
    }
}
