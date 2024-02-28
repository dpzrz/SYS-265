#secure-ssh.sh
#author dperez
#creates a new ssh user using $1 parameter
#adds a public key from the local repo or curled from the remote reop
#removes roots ability to ssh in

# Check if script is run with sudo
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run with sudo."
    exit 1
fi

# Prompt for the username
read -p "Enter the username for the new user: " USERNAME

# Check if username is provided
if [ -z "$USERNAME" ]; then
    echo "Username is required."
    exit 1
fi

# Create user with home directory and specified shell
sudo useradd -m -d "/home/$USERNAME" -s /bin/bash "$USERNAME"

# Check if user is added successfully
if [ $? -ne 0 ]; then
    echo "Failed to add user $USERNAME."
    exit 1
fi

# Create .ssh directory and copy public key
sudo mkdir "/home/$USERNAME/.ssh"
sudo cp /home/diego/tech-journal-private/public-keys/id_rsa.pub "/home/$USERNAME/.ssh/authorized_keys"

# Set correct permissions
sudo chmod 700 "/home/$USERNAME/.ssh"
sudo chmod 600 "/home/$USERNAME/.ssh/authorized_keys"
sudo chown -R "$USERNAME:$USERNAME" "/home/$USERNAME/.ssh"

echo "Passwordless SSH access setup for user $USERNAME."
