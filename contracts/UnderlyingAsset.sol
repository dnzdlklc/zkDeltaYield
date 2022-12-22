// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;
abstract contract UnderlyingAsset {
    // Function that transfers units of the underlying asset from one address to another
    function transfer(address to, uint256 value) public virtual;

    // Function that returns the number of units of the underlying asset owned by an address
    function balanceOf(address owner) public virtual view returns (uint256);
}