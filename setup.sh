#!/bin/bash

echo "🚀 Starting Full Setup..."

# 🟢 Update system packages
echo "🔄 Updating system..."
sudo apt update && sudo apt upgrade -y

# 🟢 Install required dependencies
echo "📦 Installing system dependencies (Python, pip, venv, Docker)..."
sudo apt install -y python3 python3-pip python3-venv curl wget

# 🟢 Install and start Docker (if not installed)
if ! command -v docker &> /dev/null
then
    echo "🐳 Installing Docker..."
    sudo apt install -y docker.io
    sudo systemctl start docker
    sudo systemctl enable docker
else
    echo "🐳 Docker already installed!"
fi

# 🟢 Add current user to Docker group to run commands without sudo
sudo usermod -aG docker $USER

# 🟢 Create and activate virtual environment
echo "🐍 Setting up Python Virtual Environment..."
python3 -m venv venv
source venv/bin/activate

# 🟢 Install application dependencies
echo "📥 Installing dependencies from requirements.txt..."
pip install --upgrade pip
pip install -r requirements.txt

# 🟢 Pull and start PostgreSQL in Docker
echo "🐘 Setting up PostgreSQL container..."
docker pull postgres:latest

# 🟢 Stop and remove any existing PostgreSQL container
sudo docker stop postgres-container 2>/dev/null || true
sudo docker rm postgres-container 2>/dev/null || true

# 🟢 Create a custom Docker network (avoid errors if it already exists)
sudo docker network create my_network || true

# 🟢 Run PostgreSQL container (Fixed the command)
sudo docker run -d --name postgres-container --network=my_network \
    -e POSTGRES_USER=admin \
    -e POSTGRES_PASSWORD=admin \
    -e POSTGRES_DB=students_db \
    -p 5433:5432 postgres

# 🟢 Wait for PostgreSQL to initialize
echo "⏳ Waiting for PostgreSQL to start..."
sleep 10

# 🟢 Export database URL for Flask and persist it
export DATABASE_URL="postgresql://admin:admin@localhost:5433/students_db"
echo 'export DATABASE_URL="postgresql://admin:admin@localhost:5433/students_db"' >> ~/.bashrc

# 🟢 Initialize and apply Flask migrations
echo "📌 Running database migrations..."
flask db init || true  # Ignore error if already initialized
flask db migrate -m "Initial migration"
flask db upgrade

# 🟢 Completion message
echo "✅ Setup Complete! Run your Flask app using:"
echo "source venv/bin/activate && python3 run.py"