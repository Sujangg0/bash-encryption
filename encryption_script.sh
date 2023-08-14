#!/bin/bash

# This script automates encryption and decryption using symmetric keys between two systems.

# System A

# Create folders for System A
mkdir -p /home/ghoth/System_A_Folder

# Prompt for symmetric key for System A
echo -n "Enter symmetric key for System A: "
read symmetric_keyA
echo "$symmetric_keyA" > /home/ghoth/System_A_Folder/symmetric_key.txt

# Prompt for sensitive data
echo -n "Enter sensitive data for User A: "
read sensitive_data
echo "$sensitive_data" > /home/ghoth/System_A_Folder/data.txt

# Prompt for System B's IP address
echo -n "Enter System B's IP address: "
read system_b_ip

# Copy symmetric key to System B
scp /home/ghoth/System_A_Folder/symmetric_key.txt ghoth@$system_b_ip:/home/ghoth/System_B_Folder/

# System B

# Create folders for System B
mkdir -p /home/ghoth/System_B_Folder

# Prompt for symmetric key for System B
echo -n "Enter symmetric key for System B: "
read symmetric_keyB
echo "$symmetric_keyB" > /home/ghoth/System_B_Folder/symmetric_key.txt

# Prompt for response data from User B
echo -n "Enter response data from User B: "
read response_data
echo "$response_data" > /home/ghoth/System_B_Folder/response_data.txt

# Copy symmetric key to System A
scp /home/ghoth/System_B_Folder/symmetric_key.txt ghoth@$system_a_ip:/home/ghoth/System_A_Folder/

# Encrypt Data0

# Encrypt User A's data using symmetric key
openssl enc -aes-256-cbc -base64 -in /home/ghoth/System_A_Folder/data.txt -out /home/ghoth/System_A_Folder/encrypted_data.txt -pass file:/home/ghoth/System_A_Folder/symmetric_key.txt

# Copy encrypted data to System B
scp /home/ghoth/System_A_Folder/encrypted_data.txt ghoth@$system_b_ip:/home/ghoth/System_B_Folder/

# Decrypt Data

# Decrypt User A's data on System B
openssl enc -d -aes-256-cbc -base64 -in /home/ghoth/System_B_Folder/encrypted_data.txt -out /home/ghoth/System_B_Folder/decrypted_data.txt -pass file:/home/ghoth/System_B_Folder/symmetric_key.txt

echo "Encryption and decryption process completed."
