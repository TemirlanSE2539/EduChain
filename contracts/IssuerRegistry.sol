// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// Educational prototype: maintains the list of institutions allowed to issue credentials.
contract IssuerRegistry {
    address public admin;

    struct University {
        string name;
        bool active;
    }

    mapping(address => University) public universities;

    event UniversityAdded(address indexed university, string name);
    event UniversityBlocked(address indexed university);

    constructor() {
        admin = msg.sender;
    }

    function addUniversity(address universityAddress, string memory universityName) public {
        require(msg.sender == admin, "Only admin");
        require(universityAddress != address(0), "Wrong address");
        require(bytes(universityName).length > 0, "Name is empty");
        require(!universities[universityAddress].active, "Already added");

        universities[universityAddress] = University(universityName, true);
        emit UniversityAdded(universityAddress, universityName);
    }

    function blockUniversity(address universityAddress) public {
        require(msg.sender == admin, "Only admin");
        require(universities[universityAddress].active, "University not active");

        universities[universityAddress].active = false;
        emit UniversityBlocked(universityAddress);
    }

    function isUniversityActive(address universityAddress) public view returns (bool) {
        return universities[universityAddress].active;
    }
}
