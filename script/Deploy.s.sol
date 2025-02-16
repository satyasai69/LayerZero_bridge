// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {MyOFT} from "src/OFT_Token.sol";

contract Deploy is Script {
    MyOFT oft;

    function run() public returns (MyOFT) {
        vm.startBroadcast();
        oft = new MyOFT("Test Token", "TEST", address(0), msg.sender);
        vm.stopBroadcast();
        return oft;
    }
}
