# IS580-STIG-script
IS580 STIG Script - Bash script for Ubuntu
README for Ubuntu System Security Compliance Script

Overview
This README document explains the purpose and functionality of a bash script designed to enforce specific security rules on an Ubuntu system. These rules are aligned with Security Technical Implementation Guides (STIGs) to ensure the system adheres to some standard security practices.

Script Description
The script includes functions to check and enforce various security rules on an Ubuntu system. Each rule is identified by a unique ID and has a descriptive title explaining its purpose. The script can check if a rule is already applied and, if not, enforce it. The user has the option to manually apply the rule if it's not in compliance.

Rules Covered
1. **SV-251504r832977**: Ensures accounts are not configured with blank or null passwords.
2. **SV-251503r808506**: Verifies no accounts have blank or null passwords.
3. **SV-238380r832974**: Disables the x86 Ctrl-Alt-Delete key sequence to prevent unintentional reboots.
4. **SV-251505r853450**: Disables automatic mounting of USB mass storage devices to prevent unauthorized data access.
5. **SV-255912r880905**: Configures the SSH server to use only FIPS-validated key exchange algorithms for enhanced security.

Usage
Run the script as a superuser to ensure it has the necessary permissions to check and enforce the rules. Each rule is processed sequentially, with the script checking the current status and asking the user if they want to enforce the rule if it's not in compliance. For certain rules, manual intervention might be required.

Checking a Rule
Each rule has a specific command to check its current compliance status. If the rule is in compliance, the script logs this status. Otherwise, it prompts the user to enforce the rule.

Enforcing a Rule
If a rule is not in compliance, the script can automatically enforce it. For some rules, manual steps are outlined. After enforcement, the rule is rechecked, and if it still doesn't pass, the script logs the status as "Incomplete. Check Manually."

Log File
The script maintains a log file named `STIG_ID_UBTU-20-010463_<timestamp>.txt`, recording the status of each rule checked or enforced. This file serves as a record of actions taken and their outcomes.

Prerequisites
- Ensure you have `sudo` or root access to the system.
- The script requires an Ubuntu system.
- Familiarity with basic command-line operations and system administration is recommended.

Disclaimer
This script makes significant changes to system configurations. Always backup critical data before running the script. It is recommended to test the script in a non-production environment first to understand its impact.

---

For detailed information about each rule, refer to the respective STIG documentation. This script is a tool to aid in system security compliance and does not guarantee complete security. Regular system audits and monitoring are recommended.
