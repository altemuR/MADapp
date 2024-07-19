# MADapp (Merchant Authentication Decentralized App)
A Sample Scroll Project for the Rise-In Scroll Bootcamp

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
