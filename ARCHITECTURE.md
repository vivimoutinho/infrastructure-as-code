# Architecture Decision Record (ADR) - Telephony IaC & Deployment

## Context
The goal of this project is to provide a fully automated, repeatable, and secure environment for 3CX Phone Systems on AWS, moving away from manual installations and ensuring "Infrastructure as Code" (IaC) principles.

## Architecture Design

### 1. Infrastructure Provisioning (Terraform)
* **VPC Isolation:** A dedicated Virtual Private Cloud (VPC) ensures that telephony (VoIP) traffic is segmented from other corporate workloads, reducing the blast radius of network issues.
* **Security Hardening (Cloud Level):** AWS Security Groups are configured with the principle of least privilege, specifically allowing:
    * **SIP (5060/5061) & Tunnel (5090):** For signaling and media encapsulation.
    * **HTTPS (443):** For encrypted management console access.
    * **SSH (22):** Restricted access for Ansible automation.
* **Compute:** Optimized `t3.medium` instances to handle real-time voice transcoding and concurrent call processing.

### 2. Configuration Management & Hardening (Ansible)
We utilize a multi-playbook strategy to separate OS concerns from Application concerns:
* **Stage 1 - System Setup (`setup-3cx-server.yml`):** Focuses on "Base Hardening". Performs system updates, timezone synchronization (critical for call logs), and local firewall (UFW) configuration.
* **Stage 2 - Application Deployment (`install-3cx.yml`):** Handles the automated software lifecycle. It manages GPG key imports, official 3CX repository injection, and the installation of the `3cxpbx` package.

### 3. Orchestration (Bash)
* **Unified Workflow:** A `deploy.sh` script acts as the entry point, orchestrating the handover between Terraform (Infrastructure) and Ansible (Configuration/App). It dynamically captures the provisioned IP address to populate the automation inventory.

## Key Design Decisions
* **Modularization:** Separating the "Setup" from "Install" allows for better troubleshooting and reuse of the hardening layer for other Linux-based services.
* **Defense in Depth:** Security is implemented at two layers: AWS Security Groups (Network) and Linux UFW (Host).
* **Idempotency:** All automation scripts are designed to be run multiple times, ensuring the system reaches the desired state without side effects.

---
*Maintained by Vivian Moutinho | Focus: High Availability and Operational Excellence.*
