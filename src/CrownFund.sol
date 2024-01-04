// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Donation {
    // Address of the beneficiary
    address payable public beneficiary;

    // Total amount of donations received
    uint256 public totalDonations;

    // Event emitted when a donation is made
    event DonationMade(address indexed donor, uint256 amount);

    constructor(address payable _beneficiary) public {
        beneficiary = _beneficiary;
    }

    // Function to receive donations
    function donate() public payable {
        require(msg.value > 0, "Donation amount must be greater than 0.");

        totalDonations += msg.value;
        emit DonationMade(msg.sender, msg.value);

        // Transfer the donated amount to the beneficiary
        (bool success, ) = beneficiary.call{value: msg.value}("");
        require(success, "Transfer to beneficiary failed.");
    }

    // Function to get the total donations
    function getTotalDonations() public view returns (uint256) {
        return totalDonations;
    }
}
