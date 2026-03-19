# Infrastructure as Code: AWS Networking Blueprints

This repository contains production-ready Terraform modules for deploying scalable and secure infrastructure on AWS.

## Purpose
To demonstrate a professional approach to Infrastructure as Code (IaC), focusing on modularity, resource tagging, and cloud architecture best practices.

## Technical Architecture
* **Provider:** HashiCorp Terraform
* **Cloud Platform:** AWS
* **Components:**
    * **VPC:** Custom Virtual Private Cloud with DNS support enabled.
    * **Subnets:** Segmented public/private networking strategy.
    * **Tagging Policy:** Consistent resource tagging for cost allocation and traceability.

## Design Decisions
1. **State Management:** Designed to support remote state backends (S3/DynamoDB) for team collaboration.
2. **Security:** Implemented specific CIDR blocks to ensure network isolation between tiers.
3. **Variables:** All parameters are abstracted into a `variables.tf` file to allow environment-specific deployments (Dev/Staging/Prod).

## How to use
1. Install Terraform.
2. Run `terraform init` to initialize providers.
3. Run `terraform plan` to preview infrastructure changes.
4. Run `terraform apply` to deploy to AWS.

---
*Developed with a focus on high-availability and operational consistency.*
