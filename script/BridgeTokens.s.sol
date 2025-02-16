// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {MyOFT} from "src/OFT_Token.sol";
import {SendParam, MessagingFee} from "lib/oft-evm/contracts/interfaces/IOFT.sol";

contract BridgeTokens is Script {
    function run() external {
        // Configuration
        address oftAddress = 0x9F8574f6D68182122414Cf0470220628Ecd915ff; // Your OFT contract address
        uint32 dstEid =  40333; // 40161 // Destination chain EID
        address fromAddress = 0x2373a942FEbC0ee428b266bDD58275794E7f1553; //msg.sender; // The address sending the tokens (should have tokens)
        address toAddress = 0x2373a942FEbC0ee428b266bDD58275794E7f1553; // Recipient address on the destination chain
        uint256 amount = 1000000000000000000; // Amount to bridge (1 token with 18 decimals)
        
        MyOFT oft = MyOFT(oftAddress);

        // Create the send parameters with specific options
        SendParam memory sendParam = SendParam({
            dstEid: dstEid,
            to: bytes32(uint256(uint160(toAddress))), // Convert address to bytes32
            amountLD: amount,
            minAmountLD: amount, // Set same as amount for no slippage
            extraOptions: abi.encodePacked(uint16(1), uint256(300000)), // Gas limit of 300k
            composeMsg: "",
            oftCmd: ""
        });

        // Get the messaging fee first
        MessagingFee memory msgFee = oft.quoteSend(sendParam, false);

        // Add 20% to the fee for safety
        uint256 nativeFee = (msgFee.nativeFee * 120) / 100;
        
        // Log all the fees
        console.log("Base native fee: %s wei", msgFee.nativeFee);
        console.log("Base native fee: %s ETH", msgFee.nativeFee / 1e18);
        console.log("With 20% buffer:");
        console.log("Final native fee: %s wei", nativeFee);
        console.log("Final native fee: %s ETH", nativeFee / 1e18);
        console.log("LZ token fee: %s", msgFee.lzTokenFee);

        vm.startBroadcast();

        // Send tokens cross-chain with explicit value
        oft.send{value: msgFee.nativeFee}(
            sendParam,
            msgFee,
            fromAddress // refund address (use the sender's address)
        );

        vm.stopBroadcast();
    }
}


// 0x3fEa484D7E954D13811ED91721112239F7435898 unichain test
// 0x9F8574f6D68182122414Cf0470220628Ecd915ff eth test