// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Counter {
    struct HistoryEntry {
        int256 value;
        address user;
    }

    int256 private counter;
    HistoryEntry[] private history;

    event CounterIncremented(int256 newValue, address indexed user);
    event CounterDecremented(int256 newValue, address indexed user);

    constructor() {
        counter = 0;
        history.push(HistoryEntry(counter, msg.sender));
    }

    function increment() public {
        counter++;
        history.push(HistoryEntry(counter, msg.sender));
        emit CounterIncremented(counter, msg.sender);
    }

    function decrement() public {
        counter--;
        history.push(HistoryEntry(counter, msg.sender));
        emit CounterDecremented(counter, msg.sender);
    }

    function getCurrentValue() public view returns (int256) {
        return counter;
    }

    function getHistory() public view returns (HistoryEntry[] memory) {
        return history;
    }
}
