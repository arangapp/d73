#!/bin/bash

# Log file for control node setup
LOG_FILE="/tmp/ansible-control-node-setup.log"

# Function to log messages
log() {
    local datetime=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[$datetime] $1" >> "$LOG_FILE"
}

# Function to execute commands and log output
execute_command() {
    local command="$1"
    log "Executing: $command"
    eval "$command" >> "$LOG_FILE" 2>&1
}

# Step 1: Install Python latest version on Managed host
execute_command "yum install python3 -y"

# Step 2: Set Python 3 as default
execute_command "alternatives --set python /usr/bin/python3"

# Step 3: Check Python version
execute_command "python --version"

# Step 4: Install python-pip package manager
execute_command "yum -y install python3-pip"

# Step 5: Create a new user for ansible administration & grant admin access
read -p "Enter the username for Ansible administration: " ansible_user
execute_command "useradd $ansible_user"
execute_command "passwd $ansible_user"

# Step 6: Add the user to sudoers file
echo "$ansible_user ALL=(ALL) NOPASSWD: ALL" | execute_command "tee -a /etc/sudoers"

# Step 7: Enable password-based authentication
execute_command "sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config"
execute_command "systemctl reload sshd"

# Step 8: Install Ansible as the ansible user
execute_command "su - $ansible_user -c 'pip3 install ansible --user'"

# Step 9: Check Ansible version
execute_command "su - $ansible_user -c 'ansible --version'"

# Step 10: Generate SSH key for the ansible user
execute_command "su - $ansible_user -c 'ssh-keygen'"

# Step 11: Create directory /etc/ansible and add control node IP to hosts file
execute_command "mkdir -p /etc/ansible"
echo "localhost" | execute_command "tee /etc/ansible/hosts"

# Completion message
log "Ansible control node setup completed successfully"
