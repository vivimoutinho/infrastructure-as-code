# Step 2: Configuring Server with Ansible (Hardening)
echo "Step 2: Hardening Server with Ansible..."
ansible-playbook -u ubuntu -i "$INSTANCE_IP," setup-3cx-server.yml

# Step 3: Installing 3CX Application
echo "Step 3: Installing 3CX Phone System..."
ansible-playbook -u ubuntu -i "$INSTANCE_IP," install-3cx.yml

echo "--- Deployment Successfully Completed! ---"
echo "Next step: Access http://$INSTANCE_IP:5015 to finish 3CX wizard."
