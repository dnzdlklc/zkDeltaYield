
# zkDelta Yield

This repository contains a Solidity implementation of a delta neutral strategy using futures contracts and options contracts.




## Contracts

#### FuturesContract

The `FuturesContract` contract represents a futures contract that allows a user to buy or sell the underlying asset at a predetermined price in the future.

#### OptionsContract
The `OptionsContract` contract represents an options contract that gives the holder the right, but not the obligation, to buy or sell the underlying asset at a predetermined price.

#### DeltaNeutralStrategy
The `DeltaNeutralStrategy` contract uses a `FuturesContract` to offset the impact of price movements in the underlying asset on the overall position. It allows a user to enter into a delta neutral position by buying a long position in the futures contract and selling the underlying asset, and to exit a delta neutral position by selling the long position in the futures contract and buying the underlying asset.


# Compiling and Deploying

To compile and deploy the contracts, you will need to have Hardhat installed.

1. Install the dependencies:

```
npm install
```

2. Compile the contracts:
```
npx hardhat deploy
```

3. Deploy the contracts to a local Ethereum network:
```
npx hardhat deploy
```


## Usage

To use the delta neutral strategy, follow these steps:

1. Deploy the `UnderlyingAsset` contract representing the underlying asset.
2. Deploy the `FuturesContract` contract, passing the address of the `UnderlyingAsset` contract and the settlement price as arguments.
3. Deploy the `OptionsContract` contract, passing the address of the `UnderlyingAsset` contract, the exercise price, and the expiration date as arguments.
4. Deploy the `DeltaNeutralStrategy` contract, passing the address of the `FuturesContract` contract as an argument.
5. Call the `enterDeltaNeutral` function on the `DeltaNeutralStrategy` contract to enter into a delta neutral position.
6. To exit the delta neutral position, call the `exitDeltaNeutral` function on the `DeltaNeutralStrategy` contract.

Note: This is just a sample implementation and may not be suitable for all use cases. It is recommended to carefully evaluate the risks and rewards of any trading strategy before implementing it.