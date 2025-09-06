#!/bin/bash

# CI/CD Setup Script for DevOps Project
# This script sets up only the essential components for CI/CD deployment

echo "=========================================="
echo "CI/CD Setup Script for DevOps"
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

echo "=========================================="
echo "CI/CD Setup Complete!"
echo "=========================================="
echo "Your EC2 instance is now ready for CI/CD deployment."
echo "The CI/CD pipeline will handle:"
echo "- Cloning the repository"
echo "- Creating .env files"
echo "- Deploying with Docker Compose"
echo "=========================================="
