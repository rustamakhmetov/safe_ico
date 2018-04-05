pragma solidity ^0.4.11;

import "./AbstractICO.sol";

// Объявляем интерфейс
interface MyERC20Token8 {
    function transfer(address _receiver, uint256 _amount);
    function decimals() returns(uint8);
    function getName() returns(bytes32);
}

contract BaseICO is AbstractICO {
    // Объявляем переменную для стомости токена
    uint public buyPrice;
    // Объявялем переменную для токена
    MyERC20Token8 public token;
    uint public _tokens;
    uint public __amount;

    event Log(string _message);
    event LogV(string _message, uint _value);

    // Функция для прямой отправки эфиров на контракт
    function () payable {
        emit Log("default log");
        _buy(msg.sender, msg.value);
    }

    // Вызываемая функция для отправки эфиров на контракт, возвращающая количество купленных токенов
    function buy() payable returns (uint){
        Log("buy");
        // Получаем число купленных токенов
        uint tokens = _buy(msg.sender, msg.value);
        // Возвращаем значение
        return tokens;
    }

    // Внутренняя функция покупки токенов, возвращает число купленных токенов
    function _buy(address _sender, uint _amount) internal returns (uint){
        // Рассчитываем стоимость
        buyPrice = _buy_price();
        require(buyPrice > 0);
        _tokens = _amount * (10 ** uint256(token.decimals())) / buyPrice;
        __amount = _amount;
//        // Отправляем токены с помощью вызова метода токена
        token.transfer(_sender, _tokens);
        return _tokens;
    }

    function _buy_price() internal returns(uint256) {
        Log("[Base ICO] _buy_price");
        return buyPrice;
    }

    function name() public view returns(bytes32) {
        return "BaseICO";
    }

    function isName(string value)
    public
    returns (bool)
    {
        return keccak256(bytes32ToString(this.name())) == keccak256(value);
    }

    function bytes32ToString(bytes32 x) constant returns (string) {
        bytes memory bytesString = new bytes(32);
        uint charCount = 0;
        for (uint j = 0; j < 32; j++) {
            byte char = byte(bytes32(uint(x) * 2 ** (8 * j)));
            if (char != 0) {
                bytesString[charCount] = char;
                charCount++;
            }
        }
        bytes memory bytesStringTrimmed = new bytes(charCount);
        for (j = 0; j < charCount; j++) {
            bytesStringTrimmed[j] = bytesString[j];
        }
        return string(bytesStringTrimmed);
    }

    function uint2str(uint i) internal pure returns (string){
        if (i == 0) return "0";
        uint j = i;
        uint len;
        while (j != 0){
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint k = len - 1;
        while (i != 0){
            bstr[k--] = byte(48 + i % 10);
            i /= 10;
        }
        return string(bstr);
    }

    function strConcat(string _a, string _b, string _c, string _d, string _e) internal pure returns (string) {
        bytes memory _ba = bytes(_a);
        bytes memory _bb = bytes(_b);
        bytes memory _bc = bytes(_c);
        bytes memory _bd = bytes(_d);
        bytes memory _be = bytes(_e);
        string memory abcde = new string(_ba.length + _bb.length + _bc.length + _bd.length + _be.length);
        bytes memory babcde = bytes(abcde);
        uint k = 0;
        for (uint i = 0; i < _ba.length; i++) babcde[k++] = _ba[i];
        for (i = 0; i < _bb.length; i++) babcde[k++] = _bb[i];
        for (i = 0; i < _bc.length; i++) babcde[k++] = _bc[i];
        for (i = 0; i < _bd.length; i++) babcde[k++] = _bd[i];
        for (i = 0; i < _be.length; i++) babcde[k++] = _be[i];
        return string(babcde);
    }

    function strConcat(string _a, string _b, string _c, string _d) internal pure returns (string) {
        return strConcat(_a, _b, _c, _d, "");
    }

    function strConcat(string _a, string _b, string _c) internal pure returns (string) {
        return strConcat(_a, _b, _c, "", "");
    }

    function strConcat(string _a, string _b) internal pure returns (string) {
        return strConcat(_a, _b, "", "", "");
    }
}

