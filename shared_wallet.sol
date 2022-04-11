// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "./Allowance.sol";
contract shared_wallet is Allowance
{
    function renounceOwnership() public override onlyOwner {
        revert("can't renounceOwnership here"); //not possible with this smart contract
    }//Now, let's remove the function to remove an owner. We simply stop this with a revert.

    //----------------------------------------------------------------------------------------------------

    function Withdrawal_Money(address payable Money_send_to,uint Amount) public owner_or_allowed(Amount)
    {
        require(Amount <= address(this).balance,"Contract does'nt own enough money");
        emit Allowance_Changed(msg.sender,Money_send_to,Check_Allowance[Money_send_to],Check_Allowance[Money_send_to]-Amount);
        emit MONEY_SEND(Money_send_to,Amount);
        if(!isOwner()){reduce_allowance(msg.sender,Amount);}
        Money_send_to.transfer(Amount);
    }
    function Money_in_Shared_Wallet() public view returns (uint)
    {
        return address(this).balance;
    }
    receive() external payable
    {
        emit MONEY_RECEIVED_IN_SHARED_WALLET(msg.sender,msg.value);
    }
}