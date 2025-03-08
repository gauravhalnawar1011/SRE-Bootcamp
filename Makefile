# Define variables
APP_NAME = my_rest_api
VERSION = latest
IMAGE_NAME = $(APP_NAME):$(VERSION)
CONTAINER_NAME = my_rest_api
NETWORK_NAME = my_network
POSTGRES_CONTAINER = postgres-container
PORT = 5000

.PHONY: run_script install_postgres build run stop restart logs clean

# Run the setup script BEFORE building the image
pre_build:
	@echo "🛠️ Running setup.sh before building the Docker image..."
	chmod +x setup.sh
	bash ./setup.sh

# Build the Docker image
build: pre_build
	docker build -t $(IMAGE_NAME) .

# Install PostgreSQL container
install_postgres:
	docker pull postgres:latest
	docker network create $(NETWORK_NAME) || true
	docker run -d --name $(POSTGRES_CONTAINER) --network=$(NETWORK_NAME) \
		-e POSTGRES_USER=admin -e POSTGRES_PASSWORD=admin -e POSTGRES_DB=students_db \
		postgres:latest

# Combined command for setup, build, and run
run:
	@echo "🚀 Starting full environment setup..."
	@$(MAKE) stop   # Stop any existing containers
	@$(MAKE) install_postgres
	@$(MAKE) build
	@echo "⏳ Waiting for PostgreSQL to be ready..."
	@until docker exec $(POSTGRES_CONTAINER) pg_isready -U admin; do sleep 3; done
	@docker run -d --name $(CONTAINER_NAME) --network=$(NETWORK_NAME) -p $(PORT):$(PORT) \
		-e DATABASE_URL="postgresql://admin:admin@$(POSTGRES_CONTAINER):5432/students_db" $(IMAGE_NAME)

# Stop and remove the running containers
stop:
	docker stop $(CONTAINER_NAME) $(POSTGRES_CONTAINER) || true
	docker rm $(CONTAINER_NAME) $(POSTGRES_CONTAINER) || true

# Restart the containers
restart: stop run

# View container logs
logs:
	docker logs -f $(CONTAINER_NAME)

# Clean up Docker images and containers
clean:
	docker rmi $(IMAGE_NAME) -f || true
	docker system prune -f

.PHONY: nuke

# Completely remove all related Docker resources
nuke:
	docker stop $(CONTAINER_NAME) $(POSTGRES_CONTAINER) || true
	docker rm $(CONTAINER_NAME) $(POSTGRES_CONTAINER) || true
	docker rmi $(IMAGE_NAME) postgres:latest -f || true
	docker network rm $(NETWORK_NAME) || true
	docker volume prune -f
