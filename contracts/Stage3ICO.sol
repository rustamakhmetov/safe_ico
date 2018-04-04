pragma solidity ^0.4.11;

import "./BaseICO.sol";

contract Stage3ICO is BaseICO {
    function Stage3ICO(MyERC20Token8 _token){
        token = _token;
        buyPrice = 100 finney; // 0.1 ether
    }

    function name() public view returns(bytes32) {
        return "Stage3ICO";
    }
}
