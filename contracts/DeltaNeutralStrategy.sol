// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract DeltaNeutralStrategy {
    // The address of the futures contract
    FuturesContract futuresContract;

    // The number of units of the underlying asset that are held in the delta neutral position
    uint256 deltaNeutralQuantity;

    // Constructor that sets the futures contract
    constructor(FuturesContract _futuresContract) public {
        futuresContract = _futuresContract;
    }

    // Function that allows a user to enter into a delta neutral position by buying a long position in the futures contract and selling the underlying asset
    function enterDeltaNeutral() public {
        // Verify that the caller has enough units of the underlying asset to sell
        require(futuresContract.underlyingAsset.balanceOf(msg.sender) >= deltaNeutralQuantity, "Insufficient balance");

        // Sell the units of the underlying asset
        futuresContract.underlyingAsset.transfer(futuresContract.longPosition, deltaNeutralQuantity);

        // Buy the futures contract
        futuresContract.buy.value(futuresContract.settlementPrice * deltaNeutralQuantity)();

        // Set the delta neutral quantity to the number of units of the underlying asset that are being held in the delta neutral position
        deltaNeutralQuantity = deltaNeutralQuantity;
    }

    // Function that allows a user to exit a delta neutral position by selling the long position in the futures contract and buying the underlying asset
    function exitDeltaNeutral() public {
        // Sell the futures contract
        futuresContract.sell();

        // Buy the units of the underlying asset
        futuresContract.underlyingAsset.transfer(msg.sender, deltaNeutralQuantity);

        // Set the delta neutral quantity to zero
        deltaNeutralQuantity = 0;
    }
}