# Define variables
APP_NAME=my_rest_api
VERSION=1.0.0
IMAGE_NAME=$(APP_NAME):$(VERSION)
CONTAINER_NAME=my_api_container
NETWORK_NAME=my_network
POSTGRES_CONTAINER=postgres-container
PORT=5000

.PHONY: build run stop restart logs clean

# Build the Docker image
build:
	docker build -t $(IMAGE_NAME) .

# Run the container inside my_network with DATABASE_URL
run: build
	docker run -d --name $(CONTAINER_NAME) --network=$(NETWORK_NAME) -p $(PORT):$(PORT) \
		-e DATABASE_URL="postgresql://admin:admin@$(POSTGRES_CONTAINER):5432/students_db" $(IMAGE_NAME)

# Stop and remove the running container
stop:
	docker stop $(CONTAINER_NAME) || true
	docker rm $(CONTAINER_NAME) || true

# Restart the container
restart: stop run

# View container logs
logs:
	docker logs -f $(CONTAINER_NAME)

# Clean up Docker images and containers
clean:
	docker rmi $(IMAGE_NAME) -f || true
	docker system prune -f
