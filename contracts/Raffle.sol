// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

error Raffle_SendMoreToEnterRaffle();
error Raffle_RaffleNotOpen();

contract Raffle {
    enum RaffleState {
        Open, 
        Calculating
    }
    RaffleState public s_raffleState;
    uint256 public immutable i_entranceFee;
    address payable[] public s_players;

    event RaffleEnter(address indexed player);

    constructor(uint256 entranceFee) {
        i_entranceFee = entranceFee;
    }

    function enterRaffle() external payable {
        if (msg.value < i_entranceFee) {
            revert Raffle_SendMoreToEnterRaffle();
        }
        //raffle is open
        if (s_raffleState != RaffleState.Open) {
            revert Raffle_RaffleNotOpen();
        }
        // you can enter
        s_players.push(payable(msg.sender));
        emit RaffleEnter((msg.sender));
    }


}