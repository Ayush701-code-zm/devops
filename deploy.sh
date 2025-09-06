#!/bin/bash

# Manual Deployment Script for DevOps Project
# This script can be used for manual deployment or troubleshooting

echo "=========================================="
echo "Manual Deployment Script for DevOps"
echo "=========================================="

# Set variables
PROJECT_DIR="/home/ec2-user/devops"
REPO_URL="https://github.com/Ayush701-code-zm/devops.git"

# Step 1: Navigate to project directory
echo "Step 1: Navigating to project directory..."
cd $PROJECT_DIR

# Step 2: Pull latest changes
echo "Step 2: Pulling latest changes..."
git fetch --all
git reset --hard origin/master

# Step 3: Create .env file if it doesn't exist
echo "Step 3: Creating .env file..."
if [ ! -f "server/.env" ]; then
    cat > server/.env << EOF
PORT=5000
MONGODB_URI=mongodb://localhost:27017/taskmanager
NODE_ENV=production
EOF
    echo "Created server/.env file"
else
    echo "server/.env file already exists"
fi

# Step 4: Stop existing containers
echo "Step 4: Stopping existing containers..."
docker compose down

# Step 5: Build and start containers
echo "Step 5: Building and starting containers..."
docker compose up --build -d

# Step 6: Clean up old images
echo "Step 6: Cleaning up old images..."
docker image prune -f

# Step 7: Check deployment status
echo "Step 7: Checking deployment status..."
docker compose ps

echo "=========================================="
echo "Deployment Complete!"
echo "=========================================="
echo "Your application should be accessible at:"
echo "Frontend: http://13.60.33.20:3001"
echo "Backend: http://13.60.33.20:5000"
echo ""
echo "To check logs: docker compose logs"
echo "To stop: docker compose down"
echo "To restart: docker compose up -d"
echo "=========================================="
