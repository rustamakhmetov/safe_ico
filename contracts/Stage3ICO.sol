pragma solidity ^0.4.11;

import "./BaseICO.sol";

contract Stage3ICO is BaseICO {
    function Stage3ICO(MyERC20Token8 _token){
        token = _token;
        buyPrice = 40000;
    }

    function name() public view returns(bytes32) {
        return "Stage3ICO";
    }
}
