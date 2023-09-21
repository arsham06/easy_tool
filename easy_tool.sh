#!/bin/bash

# Display a banner
echo "========================================"
echo "Easy Tools - A Simple Bash Script"
echo "========================================"

# Define the initial value for the choice variable
choice=""

# Run the script in a loop until the user selects "exit"
while [ "$choice" != "exit" ]; do
    # Define the menu
    echo "Select an option (or 'exit' to quit):"
    echo "General Options:"
    echo "1. Update and upgrade packages"
    echo "2. Change root password"
    echo "3. Add User"
    echo "----------------------------------------"
    echo "Firewall Options:"
    echo "4. Enable Firewall"
    echo "5. Disable Firewall"
    echo "6. Add Firewall Rule"
    echo "----------------------------------------"
    echo "Add Firewall Rule Options:"
    echo "  1. Allow Traffic"
    echo "  2. Deny Traffic"
    echo "----------------------------------------"
    # Add more sections and options as needed
    echo "----------------------------------------"

    # Read the user's choice
    read -p "Enter the option number: " choice

    # Perform actions based on the user's choice
    case $choice in
        1)
            echo "Updating and upgrading packages..."
            sudo apt update
            sudo apt upgrade
            ;;
        2)
            read -s -p "Enter the new root password: " new_password
            echo
            echo "Changing the root password..."
            echo -e "$new_password\n$new_password" | sudo passwd root
            ;;
        3)
            read -p "Enter the username to add: " username
            sudo adduser $username
            echo "User $username added successfully."
            ;;
        4)
            echo "Enabling the firewall..."
            sudo ufw enable
            ;;
        5)
            echo "Disabling the firewall..."
            sudo ufw disable
            ;;
        6)
            echo "Add Firewall Rule:"
            echo "Select an option:"
            echo "  1. Allow Traffic"
            echo "  2. Deny Traffic"
            read -p "Enter the sub-option number: " sub_option

            case $sub_option in
                1)
                    read -p "Enter the port: " port
                    read -p "Enter the type (tcp/udp/http): " type
                    echo "Allowing traffic on port $port, type: $type..."
                    sudo ufw allow $port/$type
                    ;;
                2)
                    read -p "Enter the IP address to deny: " ip_address
                    echo "Denying inbound traffic from IP: $ip_address..."
                    sudo ufw deny from $ip_address
                    ;;
                *)
                    echo "Invalid sub-option. Please try again."
                    ;;
            esac
            ;;
        exit)
            echo "Exiting the script. Goodbye!"
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
    esac
done
