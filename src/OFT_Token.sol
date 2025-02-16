// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
import { OFT } from "lib/oft-evm/contracts/OFT.sol";

/// @notice OFT is an ERC-20 token that extends the OFTCore contract.
contract MyOFT is OFT {
    constructor(
        string memory _name,
        string memory _symbol,
        address _lzEndpoint, // LayerZero endpoint address 
        address _delegate //owner address to mange OFT
    ) OFT(_name, _symbol, _lzEndpoint, _delegate) Ownable(_delegate) {
        // Mint initial supply to the deployer
        _mint(_delegate, 1000000000000000000 * 10**decimals());
    }
}