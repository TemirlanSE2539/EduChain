# EduChain — Initial Security Analysis

This is an initial coursework threat analysis of the local prototype. It is not a penetration-test report or an independent security audit.

| Threat | How it could happen | Potential impact | Prototype control | Further control for a real deployment |
|---|---|---|---|---|
| Administrator private-key theft | An attacker obtains the administrator wallet key through phishing, malware or unsafe storage. | The attacker could add or block issuer addresses. | Only the configured admin address can manage the registry. | Multi-signature administration, hardware-backed keys, role separation, key rotation and incident response. |
| Broken issuer access control | An unapproved account attempts to issue or revoke a credential. | Fraudulent or unauthorized credential records. | The contract checks active issuer status before issuance and checks that the original issuer performs revocation. | Independent access-control review, institution identity proofing, monitoring and adversarial tests. |
| Credential hash privacy / weak input | A predictable or unsalted hash may allow guessing of low-entropy source data; public transaction metadata may reveal activity. | Unwanted inference about a credential or its holder. | The prototype stores only a bytes32 hash and does not store names, IIN, grades or diploma files. | Use randomized commitments, minimize metadata, keep personal data off-chain, apply privacy review and use a carefully designed disclosure workflow. |

## Additional limitations

- The administrator is a single address; no multi-signature governance is implemented.
- The prototype does not implement production identity verification for universities.
- The prototype does not include encrypted off-chain document storage or a full W3C Verifiable Credentials workflow.
- A correct blockchain record does not prove that the university's underlying academic decision was correct.
- Contract events and test results do not establish legal compliance or production readiness.

## Test evidence

The current automated suite contains nine tests covering issuer registration, access restrictions, diploma anchoring, duplicate identifiers, revocation, incorrect hashes and blocked issuers. Record the actual terminal output and date when the team reruns the tests for the demo.
