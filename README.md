# MADapp (Merchant Authentication Decentralized App)
A Sample Scroll Project for the Rise-In Scroll Bootcamp

Contract Deployed and tested on the Sepolia Scroll Testnet. 
Contract Address: 0x6c1459323C49D0dF9f4B84cBBf8FA9e5caB2dE79 [Link](https://sepolia.scrollscan.com/address/0x6c1459323c49d0df9f4b84cbbf8fa9e5cab2de79)

Purpose and Functionality:
MADAPP provides a decentralized, privacy-preserving employee discount system. It allows employees from various companies to receive discounts at participating merchants without revealing their specific employer or personal information.

How it works:

1. Companies register and deposit tokens representing discount eligibility for their employees.
2. Employees receive cryptographic proofs of eligibility on their wallet app.
3. When making a purchase, the employee generates a unique QR code in their wallet app.
4. The merchant scans this QR code at the point of sale, which initiates a zero-knowledge proof transaction.
5. The smart contract verifies eligibility without revealing the employer.
6. If verified, the discount is applied, and the merchant receives compensation from the employer's deposited tokens.

## Scroll vs Ethereum

### Scenario 1: Using Scroll

Advantages:

1. Lower transaction costs, making frequent discount verifications economical.
2. Faster transaction processing, allowing near-instant verification after QR code scanning.
3. Inherits Ethereum's security through zkEVM rollup technology.

Disadvantages:

1. Smaller ecosystem compared to Ethereum mainnet.
2. Potentially lower liquidity for token swaps or integrations.

### Scenario 2: Using Ethereum

Advantages:

1. Largest and most established smart contract platform.
2. Vast ecosystem of tools, developers, and integrations.
3. Greater decentralization and security.

Disadvantages:

1. Higher transaction costs, potentially making frequent discount verifications expensive.
2. Slower transaction processing times, possibly causing delays after QR code scanning.
3. May be cost-prohibitive for frequent, small-value transactions.

## Choice and Rationale
Looking at the pros and cons of both alternatives "Scroll" seems to be the better choice for various reasons.

1. Cost-efficiency: Lower transaction costs on Scroll are crucial for frequent discount verifications, especially important as each employee-generated QR code scan triggers a transaction.
2. Speed: Faster transaction processing on Scroll ensures quick verification after the merchant scans the employee's QR code, essential for a smooth checkout experience.
3. Ethereum compatibility: Scroll's zkEVM technology allows easy integration with existing Ethereum-based wallet apps that employees might use to generate QR codes.
4. Scalability: Scroll's Layer 2 scaling solution can better handle the high volume of transactions from QR code scans across numerous merchants and employees.
5. Privacy focus: Scroll's architecture complements the privacy-centric nature of the system.

Scroll's advantages in these areas make it the better choice for this specific use case, ensuring that the discount system remains practical and user-friendly for both employees and merchants.

## Contract Overview

The MADApp contract is built using Solidity and incorporates OpenZeppelin's ERC20, Ownable, and ReentrancyGuard contracts for token functionality, access control, and security.

### Key Features:

- Merchant registration and management
- Customer registration
- Discount token issuance and redemption
- Tracking of discount usage and merchant performance

## Contract Structure

### Main Components:

1. ERC20 Token: "Discount Token" (DISC) used for redeeming discounts
2. Merchant Registry: Stores information about registered merchants
3. Customer Registry: Tracks registered customers and their discount usage
4. Owner Functions: For managing the platform

### Key Structs:

- `Merchant`: Stores merchant details (registration status, discount percentage, total discounts given, customer count)
- `Customer`: Tracks customer's discount usage (total discounts received, last redemption time)

## Functions

### Admin Functions (Ownable)

1. `constructor(address initialOwner)`:
    - Initializes the contract, minting initial token supply to the owner.
2. `addCustomer(address _customer)`:
    - Registers a new customer address.
    - Only callable by the owner.
3. `issueDiscountTokens(address _to, uint256 _amount)`:
    - Mints new discount tokens to a registered customer.
    - Only callable by the owner.

### Merchant Functions

1. `registerMerchant(uint256 _discountPercentage)`:
    - Allows a merchant to register with a specified discount percentage.
    - Discount percentage must be between 1 and MAX_DISCOUNT_PERCENTAGE.
2. `updateDiscountPercentage(uint256 _newPercentage)`:
    - Allows a registered merchant to update their discount percentage.

### Customer Functions

1. `redeemDiscount(address _merchant, uint256 _purchaseAmount)`:
    - Allows a registered customer to redeem a discount from a registered merchant.
    - Checks for customer registration, merchant validity, cooldown period, and sufficient token balance.
    - Burns the appropriate amount of discount tokens.
    - Updates merchant and customer statistics.

### View Functions

1. `getMerchantInfo(address _merchant)`:
    - Returns detailed information about a specific merchant.
2. `getCustomerInfo(address _customer)`:
    - Returns discount usage information for a specific customer.
3. `getTotalMerchants()`:
    - Returns the total number of registered merchants.
4. `hasUserUsedMerchant(address _customer, address _merchant)`:
    - Checks if a specific customer has used a specific merchant's discount before.

## Security Features

- ReentrancyGuard: Prevents reentrancy attacks on critical functions.
- Ownable: Restricts admin functions to the contract owner.
- Cooldown Period: Prevents abuse by limiting how often a customer can redeem discounts.
- Customer Registration: Ensures only registered customers can receive and redeem discounts.

## Usage

1. Deploy the contract, specifying the initial owner address.
2. The owner adds customers using `addCustomer`.
3. Merchants register themselves using `registerMerchant`.
4. The owner issues discount tokens to customers with `issueDiscountTokens`.
5. Customers can redeem discounts at registered merchants using `redeemDiscount`.
6. Use view functions to check merchant and customer information.

## Note

This contract is only a demo project designed for use on the Scroll blockchain for the RiseIn Scroll Bootcamp.
