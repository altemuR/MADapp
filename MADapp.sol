// SPDX-License-Identifier: MIT
//This project is for the RiseIn Scroll Bootcamp
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract MADApp is ERC20, Ownable, ReentrancyGuard {
    struct Merchant {
        bool isRegistered;
        uint256 discountPercentage;
        uint256 totalDiscountsGiven;
        uint256 customerCount;
    }

    struct Customer {
        uint256 totalDiscountsReceived;
        uint256 lastRedemptionTime;
    }

    mapping(address => Merchant) public merchants;
    mapping(address => Customer) public customers;
    mapping(address => mapping(address => bool)) public hasCustomerUsedMerchant;
    mapping(address => bool) public isCustomer;

    uint256 public constant MAX_DISCOUNT_PERCENTAGE = 50;
    uint256 public constant REDEMPTION_COOLDOWN = 1 days;
    uint256 public merchantCount;

    event MerchantRegistered(address merchant, uint256 discountPercentage);
    event DiscountRedeemed(address customer, address merchant, uint256 amount);
    event MerchantUpdated(address merchant, uint256 newDiscountPercentage);
    event TokensIssued(address to, uint256 amount);
    event CustomerAdded(address customer);

    constructor(address initialOwner) 
        ERC20("Discount Token", "DISC") 
        Ownable(initialOwner)
    {
        _mint(initialOwner, 1000000 * 10**decimals());
    }

    function addCustomer(address _customer) external onlyOwner {
        require(!isCustomer[_customer], "Address is already a customer");
        isCustomer[_customer] = true;
        emit CustomerAdded(_customer);
    }

    function registerMerchant(address _merchant, uint256 _discountPercentage) external onlyOwner {
        require(!merchants[_merchant].isRegistered, "Merchant already registered");
        require(_discountPercentage > 0 && _discountPercentage <= MAX_DISCOUNT_PERCENTAGE, "Invalid discount percentage");

        merchants[_merchant] = Merchant(true, _discountPercentage, 0, 0);
        merchantCount++;
        emit MerchantRegistered(_merchant, _discountPercentage);
    }

    function issueDiscountTokens(address _to, uint256 _amount) external onlyOwner {
        require(isCustomer[_to], "Can only issue tokens to registered customers");
        _mint(_to, _amount);
        emit TokensIssued(_to, _amount);
    }

    function redeemDiscount(address _merchant, uint256 _purchaseAmount) external nonReentrant {
        require(isCustomer[msg.sender], "Only registered customers can redeem discounts");
        require(merchants[_merchant].isRegistered, "Merchant not registered");
        require(block.timestamp >= customers[msg.sender].lastRedemptionTime + REDEMPTION_COOLDOWN, "Redemption cooldown not met");
        
        uint256 discountAmount = (_purchaseAmount * merchants[_merchant].discountPercentage) / 100;
        require(balanceOf(msg.sender) >= discountAmount, "Insufficient discount tokens");

        _burn(msg.sender, discountAmount);
        
        merchants[_merchant].totalDiscountsGiven += discountAmount;
        customers[msg.sender].totalDiscountsReceived += discountAmount;
        customers[msg.sender].lastRedemptionTime = block.timestamp;

        if (!hasCustomerUsedMerchant[msg.sender][_merchant]) {
            hasCustomerUsedMerchant[msg.sender][_merchant] = true;
            merchants[_merchant].customerCount++;
        }

        emit DiscountRedeemed(msg.sender, _merchant, discountAmount);
    }

    function updateDiscountPercentage(address _merchant, uint256 _newPercentage) external onlyOwner {
        require(merchants[_merchant].isRegistered, "Merchant not registered");
        require(_newPercentage > 0 && _newPercentage <= MAX_DISCOUNT_PERCENTAGE, "Invalid discount percentage");

        merchants[_merchant].discountPercentage = _newPercentage;
        emit MerchantUpdated(_merchant, _newPercentage);
    }

    function getMerchantInfo(address _merchant) external view returns (bool isRegistered, uint256 discountPercentage, uint256 totalDiscountsGiven, uint256 customerCount) {
        Merchant memory merchant = merchants[_merchant];
        return (merchant.isRegistered, merchant.discountPercentage, merchant.totalDiscountsGiven, merchant.customerCount);
    }

    function getCustomerInfo(address _customer) external view returns (uint256 totalDiscountsReceived, uint256 lastRedemptionTime) {
        Customer memory customer = customers[_customer];
        return (customer.totalDiscountsReceived, customer.lastRedemptionTime);
    }

    function getTotalMerchants() external view returns (uint256) {
        return merchantCount;
    }

    function hasUserUsedMerchant(address _customer, address _merchant) external view returns (bool) {
        return hasCustomerUsedMerchant[_customer][_merchant];
    }
}