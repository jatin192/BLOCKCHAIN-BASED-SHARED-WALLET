// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.7;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
contract Allowance is Ownable
{
    function isOwner() internal view returns(bool) {  //returns *** something //owner =owner()
        return owner() == msg.sender;
    }
    event Allowance_Changed(address BY_WHO,address BY_WHOM ,uint OLD_AMOUNT,uint NEW_AMOUNT);
    event MONEY_SEND(address indexed _beneficiary, uint _amount);
    event MONEY_RECEIVED_IN_SHARED_WALLET(address BY_WHO,uint AMOUNT);

    mapping(address=>uint) public Check_Allowance;

    function set_allowance(address Address,uint Amount) public onlyOwner
    {
        emit Allowance_Changed(msg.sender,Address, Check_Allowance[Address], Amount);
        Check_Allowance[Address]=Amount;       
    }
    modifier owner_or_allowed(uint amount){require(isOwner() || Check_Allowance[msg.sender]>= amount,"You are not Allowed");_;}

    function reduce_allowance(address  i,uint  amount) internal 
    {
        emit Allowance_Changed(msg.sender,i, Check_Allowance[i], Check_Allowance[i]-amount);
        Check_Allowance[i]=Check_Allowance[i]-amount;
    }
}
// address owner;
    // constructor ()
    // {
    //     owner=msg.sender;
    // }
    // modifier only_owner()
    // {
    //     require(isOwner(),"You are not Allowed");  //not return
    //     _;
    // }