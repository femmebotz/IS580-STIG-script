#Kathryn Heard
#IS580
#UBUNTU STIG Bash Script

#!/bin/bash

# Function to enforce a rule
enforce_rule() {
    echo "Enforcing Rule $1: $2..."
    eval "$3"
    # Re-check the rule
    if eval "$4"; then
        echo "$1: $2 - Complete" | tee -a $LOG_FILE
    else
        echo "$1: $2 - Incomplete. Check Manually." | tee -a $LOG_FILE
    fi
}

# Function to check a rule
check_rule() {
    echo "Checking Rule $1: $2..."
    if eval "$3"; then
        echo "$1: $2 - Complete" | tee -a $LOG_FILE
    else
        echo "$1: $2 - Incomplete. Would you like to enforce this rule now? (y/n)"
        read -r choice
        if [ "$choice" = "y" ]; then
            enforce_rule "$1" "$2" "$4" "$3"
        else
            echo "$1: $2 - Incomplete" | tee -a $LOG_FILE
        fi
    fi
}
# Log file naming
LOG_FILE="STIG_ID_UBTU-20-010463_$(date +%Y%m%d_%H%M%S).txt"

# Rule SV-251504r832977
rule_title="The Ubuntu operating system must not allow accounts configured with blank or null passwords."
check_rule "SV-251504r832977" "$rule_title"\
           "grep -qv nullok /etc/pam.d/common-password" \
           "sed -i '/nullok/d' /etc/pam.d/common-password"

# Rule SV-251503r808506
rule_title="The Ubuntu operating system must not have accounts configured with blank or null passwords."
check_rule "SV-251503r808506" "$rule_title"\
           "sudo awk -F: '\$2 {next} {exit 1}' /etc/shadow" \
           "echo 'Please manually reset the password for listed users.'"

# Rule SV-238380r832974
rule_title="The Ubuntu operating system must disable the x86 Ctrl-Alt-Delete key sequence."
check_rule "SV-238380r832974" "$rule_title"\
           "systemctl status ctrl-alt-del.target | grep -q 'Loaded: masked'" \
           "sudo systemctl disable ctrl-alt-del.target && sudo systemctl mask ctrl-alt-del.target && sudo systemctl daemon-reload"

# Rule SV-251505r853450
rule_title="The Ubuntu operating system must disable automatic mounting of Universal Serial Bus (USB) mass storage driver."
check_rule "SV-251505r853450" "$rule_title"\
           "grep -q 'install usb-storage /bin/true' /etc/modprobe.d/* && grep -q 'blacklist usb-storage' /etc/modprobe.d/*" \
           "sudo su -c 'echo install usb-storage /bin/true >> /etc/modprobe.d/DISASTIG.conf' && sudo su -c 'echo blacklist usb-storage >> /etc/modprobe.d/DISASTIG.conf'"
           
# Rule SV-255912r880905
rule_title="The Ubuntu operating system SSH server must be configured to use only FIPS-validated key exchange algorithms."
check_rule "SV-255912r880905" "$rule_title"\
           "grep -i 'KexAlgorithms ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256' /etc/ssh/sshd_config" \
           "sudo sed -i '/^KexAlgorithms /d' /etc/ssh/sshd_config && echo 'KexAlgorithms ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256' | sudo tee -a /etc/ssh/sshd_config && sudo systemctl restart sshd"



echo "Script execution completed. Check the log file: $LOG_FILE for a detailed report."