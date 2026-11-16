# EduChain — Final Project Technical Prototype

> Educational project for the course Introduction to Finance. Not a real product, service or investment offer. Do not use with real funds.

## Purpose

EduChain is a teaching prototype for blockchain-based diploma verification. A university that has been approved by the administrator can anchor a diploma identifier and document hash. A verifier can check whether the submitted hash matches an active, non-revoked credential.

The prototype uses invented test data only. It does not store student names, IIN, grades, diploma files or other personal information on-chain.

## Included Files

- `contracts/IssuerRegistry.sol` — administrator-managed list of approved universities.
- `contracts/CredentialAnchor.sol` — stores credential hashes and revocation status.
- `test/EduChain.js` — automated tests for core functions and access restrictions.
- `docs/sequence-diagram.mmd` — sequence diagram source.
- `docs/security-analysis.md` — initial security threat analysis.

## Requirements

- Node.js installed.
- npm installed.

## Installation and Execution on Windows PowerShell

Open this project folder in VS Code and select **Terminal → New Terminal**.

Use the following commands:

```powershell
npm.cmd install
npm.cmd run compile
npm.cmd test
```

To start a local test blockchain:

```powershell
npm.cmd run node
```

Keep the terminal open while the local node is running. This is a local development network only.

## Expected Test Result

The test suite should report **9 passing**.

If the result differs, investigate the error before recording the demonstration video.

## Security and Limitations

This is a simplified coursework prototype, not production software. It has not undergone an independent security audit, legal review, penetration test or production deployment.

The administrator is a single account. The prototype does not implement institutional multi-signature governance, identity proofing, encrypted off-chain storage, W3C Verifiable Credential issuance or a production key-recovery process.

A passing test suite proves only that the tested behaviours work in the local development environment. It does not prove market demand, legal compliance or production security.

## Project Repository

GitHub: https://github.com/TemirlanSE2539/EduChain

## Disclaimer

This project is developed exclusively for educational purposes. It does not provide real diploma verification services and must not be used with real personal data or funds.