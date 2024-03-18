#!/bin/bash

# Log file path
LOG_FILE="/tmp/ansible_setup.log"

# Function to log messages to the log file
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# Function to create user and set password
create_user() {
    log_message "Creating user..."
    sudo useradd -m $USERNAME
    echo "$USERNAME:$PASSWORD" | sudo chpasswd
    log_message "User created and password set."
}

# Function to add user to sudoers file
add_to_sudoers() {
    log_message "Adding user to sudoers file..."
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers > /dev/null
    log_message "User added to sudoers file."
}

# Function to generate SSH key pair
generate_ssh_key() {
    log_message "Generating SSH key pair..."
    sudo -u $USERNAME ssh-keygen -t rsa -b 4096 -f /home/$USERNAME/.ssh/id_rsa -N ""
    log_message "SSH key pair generated successfully."
}

# Function to enable password-based authentication
enable_password_auth() {
    log_message "Enabling password-based authentication..."
    sudo sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
    sudo systemctl restart sshd
    log_message "Password-based authentication enabled."
}

# Function to create ansible directory and configuration files
setup_ansible() {
    log_message "Setting up Ansible directory and configuration files..."
    sudo mkdir -p /etc/ansible
    sudo ansible-config init --disabled > /etc/ansible/ansible.cfg
    sudo ansible-config init --disabled -t all >> /etc/ansible/ansible.cfg
    sudo touch /etc/ansible/hosts
    log_message "Ansible directory and configuration files set up."
}

# Function to install Ansible
install_ansible() {
    log_message "Installing Ansible..."
    sudo yum update -y
    sudo yum install ansible -y
    log_message "Ansible installed successfully."
}

# Function to verify Ansible version
verify_ansible_version() {
    log_message "Verifying Ansible version..."
    ansible --version >> "$LOG_FILE" 2>&1
    log_message "Ansible version verified."
}

# Main script
if [ "$(whoami)" != "root" ]; then
    echo "Error: This script must be run with sudo privileges."
    exit 1
fi

# User input
read -p "Enter username for Ansible control node: " USERNAME
read -sp "Enter password for $USERNAME: " PASSWORD
echo

# Execute functions
create_user
add_to_sudoers
generate_ssh_key
enable_password_auth
setup_ansible
install_ansible
verify_ansible_version

echo "Ansible control node setup complete. Log file: $LOG_FILE"
