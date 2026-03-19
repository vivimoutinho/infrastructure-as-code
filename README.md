# Infrastructure as Code (IaC) - Telephony & Networking Blueprints

This repository demonstrates a complete infrastructure lifecycle for mission-critical telephony systems (3CX) hosted on AWS. It combines infrastructure provisioning with automated configuration management.

## Architecture Stack

* **Provisioning:** Terraform (AWS Provider)
* **Configuration Management:** Ansible
* **Environment:** Amazon Linux / Ubuntu Server
* **Target Application:** 3CX IP PBX

---

## 1. Infrastructure Provisioning (Terraform)
Located in the `/terraform` directory, this layer handles the networking baseline:
* **VPC & Subnets:** Custom network isolation for telephony traffic.
* **Security Groups:** Automated firewall rules at the cloud level.
* **Resources:** Scalable EC2 instances with consistent tagging for cost governance.

## 2. Server Configuration (Ansible)
Located in the `/ansible` directory, this layer automates the OS-level hardening and 3CX prerequisites:
* **Security:** Automated UFW firewall configuration for SIP (5060/5061) and RTP (9000-9500) ports.
* **System Optimization:** Timezone synchronization and dependency management.
* **Reliability:** Ensuring every server is deployed with a consistent, repeatable configuration.

## Operational Workflow
1. **Provision:** Execute `terraform apply` to create the VPC and EC2 instances.
2. **Configure:** Run `ansible-playbook setup-3cx-server.yml` to prepare the instances for 3CX.

---
*Developed by Vivian Moutinho | Focus: High Availability, Automation, and Operational Consistency.*
