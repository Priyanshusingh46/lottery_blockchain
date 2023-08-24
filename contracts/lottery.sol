// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract lottery{

    address public manager;

    address payable[] public participants;

    constructor(){
    manager = msg.sender;
    }

    receive() external payable{
        require(msg.value == 1 ether);
        participants.push(payable(msg.sender));
    }

    function checkBalance() public view returns(uint)
    {
        require(msg.sender==manager);
        return address(this).balance;

    }

    function random() public view returns(uint)
    {
        return uint(keccak256(abi.encodePacked(block.prevrandao,block.timestamp,participants.length)));
    }

    function SelectWinner() public{
        require(participants.length>=3);
        require(msg.sender==manager);
        uint r = random();

        uint index = r%participants.length;

        address payable winner;
        winner = participants[index];

        winner.transfer(3 ether);
        participants = new address payable [](0);

    }

}