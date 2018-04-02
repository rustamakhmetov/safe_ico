pragma solidity ^0.4.11;

contract AbstractICO {
    function () payable;

    // Вызываемая функция для отправки эфиров на контракт, возвращающая количество купленных токенов
    function buy() payable returns (uint);

    // Внутренняя функция покупки токенов, возвращает число купленных токенов
    function _buy(address _sender, uint256 _amount) internal returns (uint);

    function name() public view returns (bytes32);
}
