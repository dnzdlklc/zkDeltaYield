// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import "./UnderlyingAsset.sol";

// A futures contract that allows a user to buy or sell the underlying asset at a predetermined price in the future
contract Futures {
    // The address of the underlying asset
    UnderlyingAsset underlyingAsset;

    // The price at which the futures contract can be settled
    uint256 settlementPrice;

    // The number of units of the underlying asset that are represented by the contract
    uint256 quantity;

    // The long position holder
    address longPosition;

    // The short position holder
    address payable shortPosition;

    // Constructor that sets the underlying asset and settlement price
    constructor(UnderlyingAsset _underlyingAsset, uint256 _settlementPrice) {
        underlyingAsset = _underlyingAsset;
        settlementPrice = _settlementPrice;
    }

    // Function that allows a user to enter into a long position by buying the futures contract
    function buy() public payable {
        // Verify that the caller has enough Ether to buy the contract
        require(msg.value >= settlementPrice * quantity, "Insufficient funds");

        // Transfer the Ether to the short position holder
        shortPosition.transfer(msg.value);

        // Set the long position holder to the caller
        longPosition = msg.sender;
    }

    // Function that allows a user to enter into a short position by selling the futures contract
    function sell() public {
        // Verify that the caller has enough units of the underlying asset to sell
        require(underlyingAsset.balanceOf(msg.sender) >= quantity, "Insufficient balance");

        // Transfer the units of the underlying asset to the long position holder
        underlyingAsset.transfer(longPosition, quantity);

        // Set the short position holder to the caller
        shortPosition = msg.sender;
    }

    // Function that allows the long and short position holders to settle the contract by exchanging the underlying asset or the settlement price in Ether
    function settle() public {
        // If the price of the underlying asset is greater than the settlement price, the long position holder receives the difference in Ether from the short position holder
        if (underlyingAsset.balanceOf(longPosition) > settlementPrice) {
            shortPosition.transfer(underlyingAsset.balanceOf(longPosition) - settlementPrice);
        }
        // If the price of the underlying asset is less than the settlement price, the short position holder receives the difference in Ether from the long position holder
        else if (underlyingAsset.balanceOf(longPosition) < settlementPrice) {
            longPosition.transfer(settlementPrice - underlyingAsset.balanceOf(longPosition));
        }
        // If the price of the underlying asset is equal to the settlement price, no exchange occurs
    }
}