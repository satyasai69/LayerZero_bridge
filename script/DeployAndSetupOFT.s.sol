// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {Script} from "forge-std/Script.sol";
import {MyOFT} from "src/OFT_Token.sol";
import {SetupOFT} from "./SetupOFT.s.sol";

contract DeployAndSetupOFT is Script {
    function run() external {
        // Get deployment parameters from environment
     //   uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address lzEndpoint = 0x6EDCE65403992e310A62460808c4b910D972f10f; // vm.envAddress("LZ_ENDPOINT");
        uint32 remoteEid =40161; //40333; // Sepolia Testnet EID
        address sendLib = 0xcc1ae8Cf5D3904Cef3360A9532B477529b177cCE;// vm.envAddress("SEND_LIB");
        address receiveLib = 0xdAf00F5eE2158dD58E0d3857851c432E34A3A851; //vm.envAddress("RECEIVE_LIB");
        address executor = 0x718B92b5CB0a5552039B593faF724D182A881eDA; //vm.envAddress("EXECUTOR");
        address delegate = 0x2373a942FEbC0ee428b266bDD58275794E7f1553; //vm.envAddress("DELEGATE");
        address remotePeer = 0x3fEa484D7E954D13811ED91721112239F7435898;//vm.envAddress("REMOTE_PEER"); // Address of the OFT on the other chain
        
        // Deploy MyOFT
        vm.startBroadcast(); //deployerPrivateKey
        MyOFT oft = new MyOFT(
            "Test Token",
            "TEST",
            lzEndpoint,
            delegate  // Pass the delegate address
        );
        vm.stopBroadcast();

        // Setup DVNs (example using Google Cloud and LayerZero Labs DVNs)
        address[] memory requiredDVNs = new address[](2);
        requiredDVNs[0] =0x25f492A35ec1E60eBCF8A3DD52a815C2D167f4C3; // sep eth - 0x25f492A35ec1E60eBCF8A3DD52a815C2D167f4C3; // First DVN
        requiredDVNs[1] = 0x8eebf8b423B73bFCa51a1Db4B7354AA0bFCA9193; // LayerZero Labs DVN

        // Setup OFT configurations
        SetupOFT setup = new SetupOFT();
        setup.run(
            address(oft),
            lzEndpoint,
            remoteEid,
            sendLib,
            receiveLib,
            executor,
            requiredDVNs,
            remotePeer  // Pass the remote peer address
        );
    }
}


//https://endpoints.omniatech.io/v1/unichain/sepolia/public

// forge script script/DeployAndSetupOFT.s.sol   --rpc-url https://ethereum-sepolia-rpc.publicnode.com --account myaccount --verify --etherscan-api-key 7FBHZ9BUWHBZKTHXZAVZZJSS2X74NPARGG   --broadcast   -vvv


// forge script script/DeployAndSetupOFT.s.sol   --rpc-url https://endpoints.omniatech.io/v1/unichain/sepolia/public --account myaccount --verify --etherscan-api-key 7FBHZ9BUWHBZKTHXZAVZZJSS2X74NPARGG   --broadcast   -vvv


