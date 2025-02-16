// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {MyOFT} from "src/OFT_Token.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract Lsend is Script {
    address oftAddress = DevOpsTools.get_most_recent_deployment("MyOFT", block.chainid);
    MyOFT myoftContract = MyOFT(oftAddress);

    function setUp() public {
      //  myoftContract.send(1, address(this), "0x", "0x", 0, {value: 10_000_000_000_000_000_000});();
    }
}
