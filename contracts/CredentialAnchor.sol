// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

interface IIssuerRegistry {
    function isUniversityActive(address universityAddress) external view returns (bool);
}

// Educational prototype. Never store personal information or full diploma files on-chain.
contract CredentialAnchor {
    IIssuerRegistry public registry;

    struct Diploma {
        address university;
        bytes32 diplomaHash;
        bool exists;
        bool revoked;
    }

    mapping(bytes32 => Diploma) public diplomas;

    event DiplomaAnchored(bytes32 indexed diplomaId, address indexed university, bytes32 diplomaHash);
    event DiplomaRevoked(bytes32 indexed diplomaId, address indexed university);

    constructor(address registryAddress) {
        require(registryAddress != address(0), "Wrong registry address");
        registry = IIssuerRegistry(registryAddress);
    }

    function addDiploma(bytes32 diplomaId, bytes32 diplomaHash) public {
        require(registry.isUniversityActive(msg.sender), "University is not active");
        require(diplomaId != bytes32(0), "Wrong diploma ID");
        require(diplomaHash != bytes32(0), "Wrong diploma hash");
        require(!diplomas[diplomaId].exists, "Diploma already exists");

        diplomas[diplomaId] = Diploma(msg.sender, diplomaHash, true, false);
        emit DiplomaAnchored(diplomaId, msg.sender, diplomaHash);
    }

    function revokeDiploma(bytes32 diplomaId) public {
        require(diplomas[diplomaId].exists, "Diploma not found");
        require(diplomas[diplomaId].university == msg.sender, "Not your diploma");
        require(!diplomas[diplomaId].revoked, "Already revoked");

        diplomas[diplomaId].revoked = true;
        emit DiplomaRevoked(diplomaId, msg.sender);
    }

    function checkDiploma(bytes32 diplomaId, bytes32 diplomaHash) public view returns (bool) {
        Diploma memory diploma = diplomas[diplomaId];

        if (!diploma.exists || diploma.revoked) {
            return false;
        }

        if (!registry.isUniversityActive(diploma.university)) {
            return false;
        }

        return diploma.diplomaHash == diplomaHash;
    }
}
