# EduChain — Final Project Technical Prototype

> Educational project for the course Introduction to Finance. Not a real product, service or investment offer. Do not use with real funds.

## Purpose

EduChain is a teaching prototype for blockchain-based diploma verification. A university that has been approved by the administrator can anchor a diploma identifier and document hash. A verifier can check whether the submitted hash matches an active, non-revoked credential.

The prototype uses invented test data only. It does not store student names, IIN, grades, diploma files or other personal information on-chain.

## Included files

- `contracts/IssuerRegistry.sol` — administrator-managed list of approved universities.
- `contracts/CredentialAnchor.sol` — stores credential hashes and revocation status.
- `test/EduChain.js` — automated tests for core functions and access restrictions.
- `docs/sequence-diagram.mmd` — sequence diagram source.
- `docs/security-analysis.md` — initial security threat analysis for the report.

## Requirements

- Node.js installed
- npm installed

## Run on Windows PowerShell

Open this folder in VS Code, then choose **Terminal → New Terminal**.

Because PowerShell may block the `npm.ps1` script on some Windows installations, use `npm.cmd`:

```powershell
npm.cmd install
npm.cmd run compile
npm.cmd test
```

To start a local test blockchain:

```powershell
npm.cmd run node
```

Keep that terminal open while the local node is running. This is a local development network only.

## Expected test result

The test suite should report **9 passing**. If the result differs, copy the complete terminal output and investigate before recording a demo.

## Important limitations

This is a simplified coursework prototype, not production software. It has not undergone an independent security audit, legal review, penetration test or production deployment. The administrator is a single account, and the prototype does not implement institutional multi-signature governance, identity proofing, encrypted off-chain storage, W3C Verifiable Credential issuance, or a production key-recovery process.

A passing test suite proves only that the tested behaviours work in the local development environment. It does not prove market demand, legal compliance, or production security.
