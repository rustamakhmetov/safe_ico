pragma solidity ^0.4.0;

import "./BaseICO.sol";

contract Stage1ICO is BaseICO {
    function Stage1ICO(MyERC20Token8 _token){
        token = _token;
        buyPrice = 10000;
    }

    function name() public view returns(bytes32) {
        return "Stage1ICO";
    }
}
