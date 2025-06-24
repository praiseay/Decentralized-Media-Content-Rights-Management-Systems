# Decentralized Media Content Rights Management System

A comprehensive blockchain-based system for managing media content rights, licensing, usage tracking, revenue distribution, and compliance monitoring using Clarity smart contracts.

## Overview

This system provides a decentralized solution for media content rights management, enabling content creators, rights holders, and licensees to interact transparently and securely. The system consists of five interconnected smart contracts that handle different aspects of media rights management.

## System Architecture

### Core Contracts

1. **Rights Manager Contract** (`rights-manager.clar`)
    - Validates and registers media content rights managers
    - Manages content ownership and registration
    - Tracks manager reputation and content counts

2. **Licensing Coordinator Contract** (`licensing-coordinator.clar`)
    - Coordinates content licensing agreements
    - Manages different license types (exclusive, non-exclusive, royalty-free)
    - Handles license pricing and duration

3. **Usage Tracker Contract** (`usage-tracker.clar`)
    - Tracks content usage in real-time
    - Records usage patterns and statistics
    - Monitors compliance with licensing terms

4. **Revenue Distribution Contract** (`revenue-distribution.clar`)
    - Manages revenue pools for content
    - Distributes licensing revenue among stakeholders
    - Handles automatic payouts and earnings claims

5. **Compliance Monitor Contract** (`compliance-monitor.clar`)
    - Monitors licensing compliance
    - Handles violation reporting and resolution
    - Maintains compliance scores for entities

## Features

### Rights Management
- ✅ Rights manager verification and registration
- ✅ Content registration and ownership tracking
- ✅ Manager reputation system
- ✅ Content activation/deactivation

### Licensing
- ✅ Multiple license types support
- ✅ Flexible pricing models
- ✅ Usage-based licensing
- ✅ Duration-based licensing
- ✅ Exclusive licensing premiums

### Usage Tracking
- ✅ Real-time usage recording
- ✅ Daily usage statistics
- ✅ Usage violation detection
- ✅ Comprehensive usage analytics

### Revenue Distribution
- ✅ Multi-stakeholder revenue sharing
- ✅ Automated distribution calculations
- ✅ Pending earnings tracking
- ✅ Claim-based payout system

### Compliance Monitoring
- ✅ Violation reporting system
- ✅ Compliance scoring
- ✅ Penalty calculation
- ✅ Resolution tracking
- ✅ Repeat offender handling

## Getting Started

### Prerequisites
- Clarity development environment
- Stacks blockchain testnet access

### Deployment

1. Deploy contracts in the following order:
   \`\`\`bash
   # Deploy rights manager first
   clarinet deploy rights-manager.clar

   # Deploy licensing coordinator
   clarinet deploy licensing-coordinator.clar

   # Deploy usage tracker
   clarinet deploy usage-tracker.clar

   # Deploy revenue distribution
   clarinet deploy revenue-distribution.clar

   # Deploy compliance monitor
   clarinet deploy compliance-monitor.clar
   \`\`\`

2. Initialize system settings:
   \`\`\`clarity
   ;; Register initial rights managers
   (contract-call? .rights-manager register-rights-manager 'SP1234...)

   ;; Set penalty rules
   (contract-call? .compliance-monitor set-penalty-rule u1 u1 u100 u2 u1000)
   \`\`\`

## Usage Examples

### Registering Content
\`\`\`clarity
;; Register new content
(contract-call? .rights-manager register-content "content-001" 'SP1234...)
\`\`\`

### Creating a License
\`\`\`clarity
;; Set license terms
(contract-call? .licensing-coordinator set-license-terms
"content-001" u2 u1000 u1000 u10 u500)

;; Create license
(contract-call? .licensing-coordinator create-license
"content-001" 'SP5678... u2 u100 u1000)
\`\`\`

### Recording Usage
\`\`\`clarity
;; Record content usage
(contract-call? .usage-tracker record-usage
"license-001" "streaming" u1 "US-East" "Mozilla/5.0...")
\`\`\`

### Distributing Revenue
\`\`\`clarity
;; Add revenue to pool
(contract-call? .revenue-distribution add-revenue "content-001" u5000)

;; Set stakeholder shares
(contract-call? .revenue-distribution set-stakeholder-share
"content-001" 'SP1234... u60)

;; Distribute revenue
(contract-call? .revenue-distribution distribute-revenue "content-001")
\`\`\`

## API Reference

### Rights Manager
- \`register-rights-manager(manager: principal)\` - Register a new rights manager
- \`register-content(content-id: string, owner: principal)\` - Register new content
- \`is-verified-manager(manager: principal)\` - Check if manager is verified
- \`get-content-rights(content-id: string)\` - Get content rights information

### Licensing Coordinator
- \`set-license-terms(...)\` - Set licensing terms for content
- \`create-license(...)\` - Create a new license
- \`is-license-valid(license-id: string)\` - Check license validity
- \`get-license(license-id: string)\` - Get license details

### Usage Tracker
- \`record-usage(...)\` - Record content usage
- \`get-usage-summary(license-id: string)\` - Get usage statistics
- \`get-daily-usage(license-id: string, day: uint)\` - Get daily usage data

### Revenue Distribution
- \`add-revenue(content-id: string, amount: uint)\` - Add revenue to pool
- \`set-stakeholder-share(...)\` - Set stakeholder revenue share
- \`distribute-revenue(content-id: string)\` - Distribute pending revenue
- \`claim-earnings(content-id: string)\` - Claim pending earnings

### Compliance Monitor
- \`report-violation(...)\` - Report a compliance violation
- \`resolve-violation(violation-id: uint, notes: string)\` - Resolve violation
- \`get-compliance-score(entity: principal)\` - Get compliance score
- \`is-compliant(entity: principal)\` - Check compliance status

## Security Considerations

- All contracts implement proper access controls
- Revenue distribution uses secure calculation methods
- Compliance monitoring prevents gaming of the system
- Usage tracking includes validation mechanisms

## Testing

Run the test suite:
\`\`\`bash
npm test
\`\`\`

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support and questions, please open an issue in the GitHub repository.
\`\`\`

```md project="Media Rights Management" file="PR_DETAILS.md" type="markdown"
# Pull Request: Decentralized Media Content Rights Management System

## Summary
This PR introduces a comprehensive decentralized media content rights management system built with Clarity smart contracts. The system provides end-to-end functionality for managing media rights, licensing, usage tracking, revenue distribution, and compliance monitoring.

## Changes Made

### New Contracts Added
1. **rights-manager.clar** - Core rights management and verification
2. **licensing-coordinator.clar** - License creation and management
3. **usage-tracker.clar** - Real-time usage monitoring
4. **revenue-distribution.clar** - Automated revenue sharing
5. **compliance-monitor.clar** - Violation tracking and compliance scoring

### Key Features Implemented

#### Rights Management
- ✅ Rights manager registration and verification system
- ✅ Content registration with ownership tracking
- ✅ Manager reputation scoring
- ✅ Content lifecycle management (activation/deactivation)

#### Licensing System
- ✅ Multiple license types (exclusive, non-exclusive, royalty-free)
- ✅ Dynamic pricing based on duration, usage limits, and exclusivity
- ✅ License validation and expiration handling
- ✅ Flexible terms configuration per content

#### Usage Tracking
- ✅ Comprehensive usage recording with metadata
- ✅ Daily usage aggregation and statistics
- ✅ Usage limit enforcement
- ✅ Violation detection and reporting

#### Revenue Distribution
- ✅ Multi-stakeholder revenue pools
- ✅ Percentage-based revenue sharing
- ✅ Automated distribution calculations
- ✅ Claim-based payout system with pending earnings tracking

#### Compliance Monitoring
- ✅ Violation reporting with severity levels
- ✅ Dynamic penalty calculation based on violation history
- ✅ Compliance scoring system
- ✅ Resolution tracking and score recovery

### Technical Implementation

#### Data Structures
- Efficient map-based storage for all entities
- Comprehensive tracking of relationships between contracts
- Optimized data access patterns for common queries

#### Security Features
- Proper access control on all administrative functions
- Input validation and error handling
- Protection against common attack vectors
- Secure calculation methods for financial operations

#### Integration Points
- Cross-contract communication design
- Standardized error codes across all contracts
- Consistent data formats and interfaces

## Testing Strategy

### Unit Tests Coverage
- ✅ Rights manager registration and verification
- ✅ Content registration and ownership validation
- ✅ License creation and validation logic
- ✅ Usage recording and limit enforcement
- ✅ Revenue distribution calculations
- ✅ Compliance scoring and penalty calculations

### Integration Tests
- ✅ End-to-end workflow testing
- ✅ Cross-contract interaction validation
- ✅ Error handling across contract boundaries

### Edge Cases Covered
- ✅ Expired license handling
- ✅ Usage limit exceeded scenarios
- ✅ Invalid stakeholder configurations
- ✅ Compliance score edge cases
- ✅ Revenue distribution with zero amounts

## Performance Considerations

### Gas Optimization
- Efficient data structures to minimize storage costs
- Optimized calculation methods
- Batch operations where applicable
- Minimal external contract calls

### Scalability
- Modular contract design for easy upgrades
- Efficient indexing for large datasets
- Pagination support for list operations

## Security Audit Checklist

- ✅ Access control validation
- ✅ Integer overflow/underflow protection
- ✅ Input sanitization
- ✅ State consistency checks
- ✅ Reentrancy protection (where applicable)
- ✅ Error handling completeness

## Documentation

### Added Documentation
- ✅ Comprehensive README with setup instructions
- ✅ API reference for all public functions
- ✅ Usage examples and code snippets
- ✅ Architecture overview and contract interactions
- ✅ Security considerations and best practices

## Breaking Changes
None - This is a new system implementation.

## Migration Guide
Not applicable - Initial implementation.

## Deployment Instructions

1. **Prerequisites**
   - Clarity development environment
   - Stacks testnet access
   - Sufficient STX for deployment

2. **Deployment Order**
   ```bash
   # Deploy in this specific order due to dependencies
   clarinet deploy rights-manager.clar
   clarinet deploy licensing-coordinator.clar
   clarinet deploy usage-tracker.clar
   clarinet deploy revenue-distribution.clar
   clarinet deploy compliance-monitor.clar
