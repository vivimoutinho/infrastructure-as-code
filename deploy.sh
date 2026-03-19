#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "--- Starting SRE Automation Deployment ---"

# Step 1: Initialize and Apply Terraform
echo "Step 1: Provisioning Infrastructure with Terraform..."
terraform init
terraform apply -auto-approve

# Step 2: Extract the Public IP from Terraform Output
INSTANCE_IP=$(terraform output -raw instance_public_ip)

if [ -z "$INSTANCE_IP" ]; then
    echo "Error: Could not retrieve Instance IP from Terraform."
    exit 1
fi

echo "Infrastructure provisioned! IP Address: $INSTANCE_IP"

# Step 3: Run Ansible Playbook
echo "Step 2: Configuring Server with Ansible..."
# We use -u for user and --private-key if needed. Adjust as per your setup.
ansible-playbook -u ubuntu -i "$INSTANCE_IP," setup-3cx-server.yml

echo "--- Deployment Successfully Completed! ---"
