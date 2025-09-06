#!/bin/bash

# EC2 Complete Setup Script for DevOps Project
# This script sets up everything needed for CI/CD deployment

echo "=========================================="
echo "EC2 Complete Setup Script for DevOps"
echo "=========================================="

# Step 1: Update system packages
echo "Step 1: Updating system packages..."
sudo dnf update -y

# Step 2: Install Docker
echo "Step 2: Installing Docker..."
sudo dnf install -y docker

# Step 3: Add ec2-user to docker group
echo "Step 3: Adding ec2-user to docker group..."
sudo usermod -aG docker ec2-user

# Step 4: Enable and start Docker service
echo "Step 4: Enabling and starting Docker service..."
sudo systemctl enable docker
sudo systemctl start docker

# Step 5: Install Docker Compose
echo "Step 5: Installing Docker Compose..."
sudo mkdir -p /usr/local/lib/docker/cli-plugins
sudo curl -SL https://github.com/docker/compose/releases/download/v2.29.2/docker-compose-linux-x86_64 -o /usr/local/lib/docker/cli-plugins/docker-compose
sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose

# Step 6: Install Git
echo "Step 6: Installing Git..."
sudo dnf install -y git

# Step 7: Verify installations
echo "Step 7: Verifying installations..."
echo "Docker version:"
docker --version || echo "Docker not found in current session (re-login may be required)."

echo "Docker Compose version:"
docker compose version || echo "Docker Compose not found in current session (re-login may be required)."

echo "Git version:"
git --version

# Step 8: Clone repository
echo "Step 8: Cloning repository..."
cd /home/ec2-user
git clone https://github.com/Ayush701-code-zm/devops.git

# Step 9: Navigate to project directory
echo "Step 9: Navigating to project directory..."
cd /home/ec2-user/devops

# Step 10: Create .env file for server
echo "Step 10: Creating .env file for server..."
cat > server/.env << EOF
PORT=5000
MONGODB_URI=mongodb://localhost:27017/taskmanager
NODE_ENV=production
EOF

# Step 10.1: Create install_docker_amazon.sh script
echo "Step 10.1: Creating install_docker_amazon.sh script..."
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

chmod +x install_docker_amazon.sh

# Step 11: Apply docker group changes
echo "Step 11: Applying docker group changes..."
newgrp docker

# Step 12: Deploy application
echo "Step 12: Deploying application..."
docker compose up --build -d

# Step 12.1: Alternative manual deployment commands (if needed)
echo "Step 12.1: Manual deployment commands available..."
echo "If you need to run commands manually:"
echo "1. nano server/.env  # Edit environment file"
echo "2. git pull          # Pull latest changes"
echo "3. docker compose up --build -d  # Deploy"
echo "4. docker compose ps  # Check status"

# Step 13: Check deployment status
echo "Step 13: Checking deployment status..."
docker compose ps

echo "=========================================="
echo "Setup Complete!"
echo "=========================================="
echo "Your application should be accessible at:"
echo "Frontend: http://13.60.33.20:3001"
echo "Backend: http://13.60.33.20:5000"
echo ""
echo "To check logs: docker compose logs"
echo "To stop: docker compose down"
echo "To restart: docker compose up -d"
echo "=========================================="
