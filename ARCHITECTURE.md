# Architecture Decision Record (ADR) - Telephony IaC

## Context
The goal of this project is to provide a repeatable, secure, and automated environment for 3CX Telephony systems on AWS.

## Architecture Design
### 1. Infrastructure Provisioning (Terraform)
* **VPC Isolation:** We use a dedicated VPC to ensure telephony traffic is segmented from other workloads.
* **Security Hardening:** Security Groups are configured with the principle of least privilege, opening only necessary ports for SIP (5060/5061), Tunnel (5090), and Management (443).
* **State Management:** The current setup is designed for local state but is ready for S3/DynamoDB remote backend integration for team collaboration.

### 2. Configuration Management (Ansible)
* **OS Hardening:** Before installing 3CX, we perform a full system upgrade and package dependency installation.
* **Idempotency:** The playbook is designed to be idempotent, meaning it can be run multiple times without causing side effects.
* **Firewall Layer:** We implement a secondary firewall layer at the OS level using UFW (Uncomplicated Firewall) for defense-in-depth.

## Key Design Decisions
* **Instance Type:** Selected `t3.medium` to meet 3CX's minimum requirements for concurrent call processing and transcoding.
* **Modularity:** Using variables for CIDR blocks and regions to allow easy environment promotion (Dev -> Prod).
