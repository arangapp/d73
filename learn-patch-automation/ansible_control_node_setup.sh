#!/bin/bash

# Log file
LOG_FILE="ansible_control_node_setup.log"

# Function to log messages
log() {
    local datetime=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[$datetime] $1" >> "$LOG_FILE"
}

# Install Python 3
log "Installing Python 3"
sudo yum install python3 -y >> "$LOG_FILE" 2>&1

# Set Python 3 as default
log "Setting Python 3 as default"
sudo alternatives --set python /usr/bin/python3 >> "$LOG_FILE" 2>&1

# Check Python version
log "Checking Python version"
python --version >> "$LOG_FILE" 2>&1

# Install python-pip
log "Installing python-pip"
sudo yum -y install python3-pip >> "$LOG_FILE" 2>&1

# Create admin user
read -p "Enter admin username: " admin_username
log "Creating admin user: $admin_username"
sudo useradd $admin_username >> "$LOG_FILE" 2>&1
sudo passwd $admin_username >> "$LOG_FILE" 2>&1

# Add admin user to sudoers
log "Adding admin user to sudoers"
echo "$admin_username ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers >> "$LOG_FILE" 2>&1

# Enable password authentication
log "Enabling password authentication"
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config >> "$LOG_FILE" 2>&1
sudo service sshd reload >> "$LOG_FILE" 2>&1

# Install Ansible as admin user
log "Installing Ansible as admin user"
sudo pip3 install ansible --user >> "$LOG_FILE" 2>&1

# Check Ansible version
log "Checking Ansible version"
ansible --version >> "$LOG_FILE" 2>&1

# Generate SSH key
log "Generating SSH key"
su - $admin_username -c "ssh-keygen" >> "$LOG_FILE" 2>&1

# Copy SSH key to managed hosts
read -p "Enter the IP addresses of managed hosts (comma-separated): " managed_hosts
IFS=',' read -ra hosts_array <<< "$managed_hosts"
for host in "${hosts_array[@]}"; do
    log "Copying SSH key to $host"
    su - $admin_username -c "ssh-copy-id $admin_username@$host" >> "$LOG_FILE" 2>&1
done

# Create directory /etc/ansible and create an inventory file called "hosts"
log "Creating directory /etc/ansible and inventory file"
sudo mkdir -p /etc/ansible >> "$LOG_FILE" 2>&1
sudo touch /etc/ansible/hosts >> "$LOG_FILE" 2>&1
echo "localhost" | sudo tee -a /etc/ansible/hosts >> "$LOG_FILE" 2>&1

# Run ansible command as ansadmin user
log "Running Ansible ping command"
su - $admin_username -c "ansible all -m ping" >> "$LOG_FILE" 2>&1

log "Setup complete. Log stored in $LOG_FILE"
