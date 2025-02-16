// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import {MyOFT} from "src/OFT_Token.sol";

contract SetPeer is Script {
    function run() external {
        // OFT contract address - replace with your deployed OFT address
        address oftAddress = 0x9F8574f6D68182122414Cf0470220628Ecd915ff; // Replace with your OFT address
        uint32 remoteEid = 40333; //40161;  // Remote chain EID
        address remotePeer = 0x3fEa484D7E954D13811ED91721112239F7435898; // Remote peer address

        MyOFT oft = MyOFT(oftAddress);
        
        // Convert the remote peer address to bytes32
        bytes32 peerBytes = bytes32(uint256(uint160(remotePeer)));
        
        // Log the peer bytes
        console.logBytes32(peerBytes);
        
        // Also log in address format
        console.log("Remote peer address:", remotePeer);
        console.log("Remote chain EID:", remoteEid);

       // vm.startBroadcast();
        
        // Set the peer
      //  oft.setPeer(remoteEid, peerBytes);

      //  vm.stopBroadcast();
    }
}
