// Указываем версию для компилятора
pragma solidity ^0.4.11;


// Инициализация контракта
contract MyERC20Token9 {

    // Объявляем переменную в которой будет название токена
    string public name;
    // Объявляем переменную в которой будет символ токена
    string public symbol;
    // Объявляем переменную в которой будет число нулей токена
    uint8 public decimals;
    uint256 _buyPrice;

    // Объявляем переменную в которой будет храниться общее число токенов
    uint256 public totalSupply;

    uint public startTime;

    // Объявляем маппинг для хранения балансов пользователей
    mapping (address => uint256) public balanceOf;
    // Объявляем маппинг для хранения одобренных транзакций
    mapping (address => mapping (address => uint256)) public allowance;

    // Объявляем эвент для логгирования события перевода токенов
    event Transfer(address from, address to, uint256 value);
    // Объявляем эвент для логгирования события одобрения перевода токенов
    event Approval(address from, address to, uint256 value);

    event Log(string _message);
    event LogA(string _message, address _address);
    event LogV(uint _message);

    // Функция инициализации контракта
    function MyERC20Token9(){
        // Указываем число нулей
        decimals = 18;
        // Объявляем общее число токенов, которое будет создано при инициализации
        totalSupply = 10000000 * (10 ** uint256(decimals));
        // 10000000 * (10^decimals)

        // "Отправляем" все токены на баланс того, кто инициализировал создание контракта токена
        balanceOf[this] = totalSupply;

        _buyPrice = 10000;

        // Указываем название токена
        name = "MyERC20Token9";
        // Указываем символ токена
        symbol = "MET9";

        startTime = now;
    }

    // Внутренняя функция для перевода токенов
    function _transfer(address _from, address _to, uint256 _value) internal {
        LogA("_to", _to);
        require(_to != 0x0);
//        // Проверка на пустой адрес
        LogA("_from", _from);
        LogA("this", this);
        LogV(balanceOf[_from]);
        require(balanceOf[_from] >= _value);
        // Проверка того, что отправителю хватает токенов для перевода
        require(balanceOf[_to] + _value >= balanceOf[_to]);
        //

        balanceOf[_to] += _value;
        // Токены списываются у отправителя
        balanceOf[_from] -= _value;
        // Токены прибавляются получателю

        Transfer(_from, _to, _value);
        // Перевод токенов
    }

    // Функция для перевода токенов
    function transfer(address _to, uint256 _value) public {
        _transfer(this, _to, _value);
        // Вызов внутренней функции перевода
    }

    // Функция для перевода "одобренных" токенов
    function transferFrom(address _from, address _to, uint256 _value) public {
        // Проверка, что токены были выделены аккаунтом _from для аккаунта _to
        require(_value <= allowance[_from][_to]);
        allowance[_from][_to] -= _value;
        // Отправка токенов
        _transfer(_from, _to, _value);
    }

    // Функция для "одобрения" перевода токенов
    function approve(address _to, uint256 _value) public {
        allowance[msg.sender][_to] = _value;
        Approval(msg.sender, _to, _value);
        // Вызов эвента для логгирования события одобрения перевода токенов
    }

    function _buy_price() internal returns(uint256) {
        if (now > startTime + 4 minutes){
            //третий	вариант
            return _buyPrice * 100;
        }
        if (now > startTime + 2 minutes)	{
            //	второй	вариант
            return _buyPrice * 10;
        }
        // первый вариант
        return _buyPrice;
    }


    function buyPrice() public view returns (uint256) {
        return _buy_price();
    }

    // Функция для отправки эфиров на контракт
    function() payable {
        // Выполняем внутреннюю функцию контракта
        _buy(msg.sender, msg.value);
    }

    // Функция для отправки эфиров на контракт (вызываемая)
    function buy() payable {
        _buy(msg.sender, msg.value);
    }

    // Внутренняя функция покупки
    function _buy(address _from, uint256 _value) internal {
        // Получаем количество возможных для покупки токенов по курсу
        uint256 amount = _value / _buy_price();
        // Вызываем внутреннюю функцию перевода токенов
        _transfer(this, _from, amount);
    }
}