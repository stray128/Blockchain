// Ashcoins ICO
pragma solidity ^0.4.22;

contract ashcoin_ico{
    
    //Introducing max number of ashcoins applicable for sale
    uint public max_ashcoins = 1000000;
    
    //Introduction of the USD Conversion into ashcoins
    uint public usd_to_ashcoins = 1000;
    
    //Introducing the total number of ashcoins that have been bought by the investors
    uint public total_ashcoins_bought = 0;
    
    //Mapping from the investor address to its equity in ashcoins and USD
    mapping(address => uint) equity_ashcoins;
    mapping(address => uint) equity_usd;
    
    //Checking if an investor can buy Ashcoins
    modifier can_buy_ashcoins(uint usd_invested){
        require(usd_invested*usd_to_ashcoins + total_ashcoins_bought <= max_ashcoins);
        _;
    }
    
    //Getting equity in ashcoins of an investor
    function equity_in_ashcoins(address investor) external constant returns(uint){
        return equity_ashcoins[investor];
    }
    
    //Getting equity in usd of an investor
    function equity_in_usd(address investor) external constant returns(uint) {
        return equity_usd[investor];
    }
    
    //Buying Ashcoins
    function buy_ashcoins(address investor,uint usd_invested)external
    can_buy_ashcoins(usd_invested){
        uint ashcoins_bought = usd_invested*usd_to_ashcoins;
        equity_ashcoins[investor] += ashcoins_bought;
        equity_usd[investor] = equity_ashcoins[investor]/1000;
        total_ashcoins_bought = ashcoins_bought+total_ashcoins_bought;
    }
    //Selling ashcoins
    function sell_ashcoins(address investor,uint ashcoins_sold)external{
        equity_ashcoins[investor] -= ashcoins_sold;
        equity_usd[investor] = equity_ashcoins[investor]/1000;
        total_ashcoins_bought -= ashcoins_sold;
    }
    
    
}