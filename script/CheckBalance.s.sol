// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {Script, console} from "forge-std/Script.sol";
import {MyOFT} from "src/OFT_Token.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract CheckBalance is Script {
    function run() external view {
        // Configuration
        address oftAddress = 0x9F8574f6D68182122414Cf0470220628Ecd915ff; // Your OFT contract address
        address account = 0x2373a942FEbC0ee428b266bDD58275794E7f1553; // Address to check
        
        MyOFT oft = MyOFT(oftAddress);
        
        // Get balance
        uint256 balance = oft.balanceOf(account);
        console.log("Balance of %s: %s", account, balance);
    }
}
