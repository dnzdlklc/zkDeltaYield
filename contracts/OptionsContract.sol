// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import "./UnderlyingAsset.sol";

// An options contract that gives the holder the right, but not the obligation, to buy or sell the underlying asset at a predetermined price
contract OptionsContract {
    // The address of the underlying asset
    UnderlyingAsset underlyingAsset;

    // The price at which the options contract can be exercised
    uint256 exercisePrice;

    // The number of units of the underlying asset that are represented by the contract
    uint256 quantity;

    // The expiration date of the options contract
    uint256 expirationDate;

    // The holder of the options contract
    address holder;

    // The writer of the options contract
    address payable writer;

    // Constructor that sets the underlying asset, exercise price, and expiration date
    constructor(UnderlyingAsset _underlyingAsset, uint256 _exercisePrice, uint256 _expirationDate) {
        underlyingAsset = _underlyingAsset;
        exercisePrice = _exercisePrice;
        expirationDate = _expirationDate;
    }

    // Function that allows a user to buy the options contract
    function buy() public payable {
        // Verify that the caller has enough Ether to buy the contract
        require(msg.value >= exercisePrice * quantity, "Insufficient funds");

        // Transfer the Ether to the writer
        writer.transfer(msg.value);

        // Set the holder to the caller
        holder = msg.sender;
    }

    // Function that allows the holder to exercise the options contract by buying or selling the underlying asset at the exercise price
    function exercise() public {
        // Verify that the options contract has not expired
        require(block.timestamp <= expirationDate, "Options contract has expired");

        // If the options contract is a call option (the right to buy the underlying asset), verify that the holder has enough Ether to buy the underlying asset at the exercise price
        if (quantity > 0) {
            require(msg.value >= exercisePrice * quantity, "Insufficient funds");
        }
        // If the options contract is a put option (the right to sell the underlying asset), verify that the holder has enough units of the underlying asset to sell
        else {
            require(underlyingAsset.balanceOf(holder) >= quantity.abs(), "Insufficient balance");
        }

        // If the options contract is a call option, transfer the Ether to the writer and the units of the underlying asset to the holder
        if (quantity > 0) {
            writer.transfer(msg.value);
            underlyingAsset.transfer(holder, quantity);
        }
        // If the options contract is a put option, transfer the units of the underlying asset to the writer and the Ether to the holder
        else {
            underlyingAsset.transfer(writer, quantity.abs());
            msg.sender.transfer(exercisePrice * quantity.abs());
        }
    }
}