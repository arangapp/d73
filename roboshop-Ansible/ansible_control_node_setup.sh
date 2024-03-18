#!/bin/bash

# Function to display messages in green color
print_green() {
    echo -e "\033[0;32m$1\033[0m"
}

# Function to display messages in red color
print_red() {
    echo -e "\033[0;31m$1\033[0m"
}

# Function to create user and set password
create_user() {
    print_green "Creating user..."
    sudo useradd -m $USERNAME
    echo "$USERNAME:$PASSWORD" | sudo chpasswd
    print_green "User created and password set."
}

# Function to add user to sudoers file
add_to_sudoers() {
    print_green "Adding user to sudoers file..."
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers > /dev/null
    print_green "User added to sudoers file."
}

# Function to generate SSH key pair
generate_ssh_key() {
    print_green "Generating SSH key pair..."
    sudo -u $USERNAME ssh-keygen -t rsa -b 4096 -f /home/$USERNAME/.ssh/id_rsa -N ""
    print_green "SSH key pair generated successfully."
}

# Function to enable password-based authentication
enable_password_auth() {
    print_green "Enabling password-based authentication..."
    sudo sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
    sudo systemctl restart sshd
    print_green "Password-based authentication enabled."
}

# Function to install Ansible
install_ansible() {
    print_green "Installing Ansible..."
    sudo yum update -y
    sudo yum install ansible -y
    print_green "Ansible installed successfully."
}

# Function to create Ansible directory and configuration files
setup_ansible() {
    print_green "Setting up Ansible directory and configuration files..."
    sudo mkdir -p /etc/ansible
    sudo touch /etc/ansible/ansible.cfg
    sudo chown $USERNAME:$USERNAME /etc/ansible/ansible.cfg
    cat <<EOT | sudo tee /etc/ansible/ansible.cfg > /dev/null
[defaults]
inventory      = /etc/ansible/hosts
EOT
    sudo touch /etc/ansible/hosts
    sudo chown $USERNAME:$USERNAME /etc/ansible/hosts
    print_green "Ansible directory and configuration files set up."
}

# Main script
if [ "$(whoami)" != "root" ]; then
    print_red "Error: This script must be run with sudo privileges."
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
install_ansible
setup_ansible

print_green "Ansible control node setup complete."
