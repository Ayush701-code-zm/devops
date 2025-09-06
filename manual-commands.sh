#!/bin/bash

# Manual Commands Script - Based on your terminal session
# This script contains all the commands you ran manually

echo "=========================================="
echo "Manual Commands Script"
echo "Based on your terminal session"
echo "=========================================="

# SSH connection command (run from Windows)
echo "1. SSH Connection (run from Windows):"
echo "ssh -i \"C:\\Users\\hp\\Downloads\\gtf67.pem\" ec2-user@13.60.33.20"
echo ""

# Create and run install_docker_amazon.sh
echo "2. Create install_docker_amazon.sh:"
cat > install_docker_amazon.sh << 'EOF'
#!/bin/bash

echo "Updating system packages..."
sudo dnf update -y

echo "Installing Docker..."
sudo dnf install -y docker

echo "Adding ec2-user to docker group..."
sudo usermod -aG docker ec2-user

echo "Enabling and starting Docker service..."
sudo systemctl enable docker
sudo systemctl start docker

echo "Verifying Docker installation..."
docker --version || echo "Docker not found in current session (re-login may be required)."

echo ""
echo "Docker installation complete on Amazon Linux 2023!"
echo "IMPORTANT: Log out and log back in (or run 'newgrp docker')"
echo "so that 'ec2-user' can run docker without sudo."
echo ""
echo "After re-login, test with:"
echo "docker run hello-world"
EOF

echo "3. Make script executable and run:"
echo "chmod +x install_docker_amazon.sh"
echo "./install_docker_amazon.sh"
echo ""

# Docker Compose installation
echo "4. Install Docker Compose:"
echo "sudo mkdir -p /usr/local/lib/docker/cli-plugins"
echo "sudo curl -SL https://github.com/docker/compose/releases/download/v2.29.2/docker-compose-linux-x86_64 -o /usr/local/lib/docker/cli-plugins/docker-compose"
echo "sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose"
echo ""

# Git installation
echo "5. Install Git:"
echo "sudo dnf install -y git"
echo ""

# Clone repository
echo "6. Clone repository:"
echo "git clone https://github.com/Ayush701-code-zm/devops.git"
echo "cd devops"
echo ""

# Create .env file
echo "7. Create .env file:"
echo "nano server/.env"
echo "# Add the following content:"
echo "PORT=5000"
echo "MONGODB_URI=mongodb://localhost:27017/taskmanager"
echo "NODE_ENV=production"
echo ""

# Git pull and deployment
echo "8. Pull latest changes and deploy:"
echo "git pull"
echo "sudo systemctl start docker"
echo "sudo systemctl enable docker"
echo "sudo usermod -a -G docker ec2-user"
echo "newgrp docker"
echo "docker compose up --build -d"
echo ""

# Check status
echo "9. Check deployment status:"
echo "docker compose ps"
echo ""

echo "=========================================="
echo "All manual commands documented!"
echo "=========================================="
