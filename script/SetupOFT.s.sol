// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {Script} from "forge-std/Script.sol";
import {MyOFT} from "src/OFT_Token.sol";
import {ILayerZeroEndpointV2} from "@layerzerolabs/lz-evm-protocol-v2/contracts/interfaces/ILayerZeroEndpointV2.sol";
import {ExecutorConfig} from "@layerzerolabs/lz-evm-messagelib-v2/contracts/SendLibBase.sol";
import {SetConfigParam} from "@layerzerolabs/lz-evm-protocol-v2/contracts/interfaces/IMessageLibManager.sol";
import {UlnConfig} from "@layerzerolabs/lz-evm-messagelib-v2/contracts/uln/UlnBase.sol";

contract SetupOFT is Script {
    uint32 public constant CONFIG_TYPE_EXECUTOR = 1;
    uint32 public constant CONFIG_TYPE_ULN = 2;

    function run(
        address oftAddress,
        address lzEndpoint,
        uint32 remoteEid,
        address sendLib,
        address receiveLib,
        address executor,
        address[] memory requiredDVNs,
        address remotePeer 
    ) external {
        // Get the endpoint contract
        ILayerZeroEndpointV2 endpoint = ILayerZeroEndpointV2(lzEndpoint);
        MyOFT oft = MyOFT(oftAddress);

        // Start broadcasting transactions with the signer
        vm.startBroadcast(); 

        // 1. Set Send and Receive Libraries
        endpoint.setSendLibrary(oftAddress, remoteEid, sendLib);
        endpoint.setReceiveLibrary(oftAddress, remoteEid, receiveLib, 0); // 0 grace period for immediate switch

        // 2. Set Send Configuration
        // Create Executor Config
        ExecutorConfig memory executorConfig = ExecutorConfig({
            maxMessageSize: 10000,
            executor: executor
        });

        // Create ULN Config for sending
        UlnConfig memory ulnConfig = UlnConfig({
            confirmations: 15, // Standard confirmation count
            requiredDVNCount: uint8(requiredDVNs.length),
            optionalDVNCount: 0,
            optionalDVNThreshold: 0,
            requiredDVNs: requiredDVNs,
            optionalDVNs: new address[](0)
        });

        // Create config params array for send config
        SetConfigParam[] memory sendConfigParams = new SetConfigParam[](2);
        
        // Executor config
        sendConfigParams[0] = SetConfigParam({
            eid: remoteEid,
            configType: CONFIG_TYPE_EXECUTOR,
            config: abi.encode(executorConfig)
        });

        // ULN config
        sendConfigParams[1] = SetConfigParam({
            eid: remoteEid,
            configType: CONFIG_TYPE_ULN,
            config: abi.encode(ulnConfig)
        });

        // Set send configuration
        endpoint.setConfig(oftAddress, sendLib, sendConfigParams);

        // 3. Set Receive Configuration
        SetConfigParam[] memory receiveConfigParams = new SetConfigParam[](1);
        receiveConfigParams[0] = SetConfigParam({
            eid: remoteEid,
            configType: CONFIG_TYPE_ULN,
            config: abi.encode(ulnConfig)
        });

        // Set receive configuration
        endpoint.setConfig(oftAddress, receiveLib, receiveConfigParams);

        // 4. Set Peer for bridging
        if (remotePeer != address(0)) {
            bytes32 peerBytes = bytes32(uint256(uint160(remotePeer)));
            oft.setPeer(remoteEid, peerBytes);
        }

        vm.stopBroadcast();
    }
}
