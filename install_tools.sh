#!/bin/bash

# Install Docker
if ! command -v docker &> /dev/null
then
    echo "🚀 Installing Docker..."
    curl -fsSL https://get.docker.com | sh
    sudo usermod -aG docker $USER
    newgrp docker
else
    echo "✅ Docker is already installed."
fi

# Install Docker Compose
if ! docker compose version &> /dev/null
then
    echo "🚀 Installing Docker Compose..."
    sudo apt-get update
    sudo apt-get install -y docker-compose-plugin
else
    echo "✅ Docker Compose is already installed."
fi

# Ensure `docker-compose` command works as an alias
if ! command -v docker-compose &> /dev/null
then
    echo "🔧 Creating docker-compose alias..."
    sudo ln -sf /usr/bin/docker /usr/local/bin/docker-compose
else
    echo "✅ docker-compose alias is already configured."
fi

# Install Make
if ! command -v make &> /dev/null
then
    echo "🚀 Installing Make..."
    sudo apt-get update
    sudo apt-get install -y make
else
    echo "✅ Make is already installed."
fi

# Refresh environment variables to ensure changes take effect
echo "🔄 Refreshing environment variables..."
source ~/.profile

echo "🎯 All necessary tools are installed successfully!"
