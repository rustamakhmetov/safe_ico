pragma solidity ^0.4.11;

import "./BaseICO.sol";

contract Stage1ICO is BaseICO {
    function Stage1ICO(MyERC20Token8 _token){
        token = _token;
        buyPrice = 1 finney; // 0.001 ether
    }

    function name() public view returns(bytes32) {
        return "Stage1ICO";
    }
}
