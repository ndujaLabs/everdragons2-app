#!/bin/bash

# Port 80 Management Script for iptables
# Usage: port80.sh -a (activate) or port80.sh -d (deactivate)

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if port 80 rule exists
check_port80_rule() {
    iptables -L INPUT -n | grep -q "tcp dpt:http"
    return $?
}

# Function to activate port 80
activate_port80() {
    print_status "Activating port 80..."
    
    # Check if rule already exists
    if check_port80_rule; then
        print_warning "Port 80 rule already exists"
        return 0
    fi
    
    # Add the rule
    iptables -A INPUT -p tcp --dport 80 -j ACCEPT
    
    if [ $? -eq 0 ]; then
        print_status "Port 80 activated successfully"
        
        # Save rules
        save_iptables_rules
    else
        print_error "Failed to activate port 80"
        exit 1
    fi
}

# Function to deactivate port 80
deactivate_port80() {
    print_status "Deactivating port 80..."
    
    # Check if rule exists
    if ! check_port80_rule; then
        print_warning "Port 80 rule does not exist"
        return 0
    fi
    
    # Remove the rule
    iptables -D INPUT -p tcp --dport 80 -j ACCEPT
    
    if [ $? -eq 0 ]; then
        print_status "Port 80 deactivated successfully"
        
        # Save rules
        save_iptables_rules
    else
        print_error "Failed to deactivate port 80"
        exit 1
    fi
}

# Function to save iptables rules
save_iptables_rules() {
    print_status "Saving iptables rules..."
    
    # Try different locations based on distribution
    if [ -d "/etc/iptables" ]; then
        iptables-save > /etc/iptables/rules.v4
        print_status "Rules saved to /etc/iptables/rules.v4"
    elif [ -d "/etc/sysconfig" ]; then
        iptables-save > /etc/sysconfig/iptables
        print_status "Rules saved to /etc/sysconfig/iptables"
    else
        # Create directory and save
        mkdir -p /etc/iptables
        iptables-save > /etc/iptables/rules.v4
        chmod +x /etc/iptables/rules.v4
        print_status "Rules saved to /etc/iptables/rules.v4"
    fi
}

# Function to show current status
show_status() {
    print_status "Current iptables status for port 80:"
    echo ""
    iptables -L INPUT -n | grep -E "(tcp dpt:http|tcp dpt:80)"
    echo ""
    
    if check_port80_rule; then
        print_status "Port 80 is currently ACTIVE"
    else
        print_status "Port 80 is currently INACTIVE"
    fi
}

# Function to show usage
show_usage() {
    echo "Usage: $0 [OPTION]"
    echo ""
    echo "Options:"
    echo "  -a, --activate    Activate port 80 (allow HTTP traffic)"
    echo "  -d, --deactivate  Deactivate port 80 (block HTTP traffic)"
    echo "  -s, --status      Show current port 80 status"
    echo "  -h, --help        Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 -a             # Activate port 80"
    echo "  $0 -d             # Deactivate port 80"
    echo "  $0 -s             # Show status"
}

# Main script logic
case "$1" in
    -a|--activate)
        activate_port80
        ;;
    -d|--deactivate)
        deactivate_port80
        ;;
    -s|--status)
        show_status
        ;;
    -h|--help)
        show_usage
        ;;
    "")
        print_error "No option provided"
        show_usage
        exit 1
        ;;
    *)
        print_error "Unknown option: $1"
        show_usage
        exit 1
        ;;
esac
