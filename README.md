# LayerZero Token Bridge

A cross-chain token bridge implementation using LayerZero's OFT (Omnichain Fungible Token) protocol, enabling token transfers between Ethereum Sepolia and Unichain Sepolia networks.

## Overview

This project implements a cross-chain token bridge using LayerZero's infrastructure. The main token contract (`MyOFT`) is an ERC-20 token that extends LayerZero's OFT implementation, allowing for seamless token transfers across different blockchain networks.

## Key Components

### MyOFT Token Contract
- Built on LayerZero's OFT (Omnichain Fungible Token) standard
- Implements ERC-20 functionality with cross-chain transfer capabilities
- Initial supply: 1,000,000,000,000,000,000 tokens (minted to delegate address)
- Supports secure and trustless cross-chain token transfers

### Main Features
1. Cross-chain token transfers between:
   - Ethereum Sepolia Testnet
   - Unichain Sepolia Network
2. Integrated with LayerZero endpoints for secure message passing
3. DVN (Data Validation Network) support for enhanced security
4. Configurable peer contracts across chains

## Technical Details

### Contract Architecture
- Base Token: ERC-20 compatible
- LayerZero Integration: Uses OFT standard for cross-chain functionality
- Security: Implements Ownable pattern for access control

### Network Configuration
- Ethereum Sepolia LayerZero Endpoint: `0x6EDCE65403992e310A62460808c4b910D972f10f`
- Remote Chain EID (Unichain Sepolia): `40161`
- DVN Integration:
  - Primary DVN: `0x25f492A35ec1E60eBCF8A3DD52a815C2D167f4C3`
  - Secondary DVN (LayerZero Labs): `0x8eebf8b423B73bFCa51a1Db4B7354AA0bFCA9193`

## Deployment

The project uses Foundry for deployment and configuration. The main deployment script (`DeployAndSetupOFT.s.sol`) handles:
1. Token contract deployment
2. DVN configuration
3. Cross-chain peer setup
4. LayerZero endpoint configuration

### Deployment Commands
```bash
# Deploy to Ethereum Sepolia
forge script script/DeployAndSetupOFT.s.sol --rpc-url https://ethereum-sepolia-rpc.publicnode.com --account myaccount --verify --broadcast -vvv

# Deploy to Unichain Sepolia
forge script script/DeployAndSetupOFT.s.sol --rpc-url https://endpoints.omniatech.io/v1/unichain/sepolia/public --account myaccount --verify --broadcast -vvv
```

## Dependencies
- OpenZeppelin Contracts
- LayerZero OFT Implementation
- Foundry (for development and deployment)

## Security Considerations
- Uses multiple DVNs for enhanced security
- Implements standard access control mechanisms
- Follows LayerZero's security best practices for cross-chain communication

## License
UNLICENSED
