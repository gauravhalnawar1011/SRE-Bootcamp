# Define variables
APP_NAME = my_rest_api
VERSION = latest
IMAGE_NAME = $(APP_NAME):$(VERSION)

# Docker Compose commands
.PHONY: install_tools start_db migrate build run stop clean

# Install required dependencies
install_tools:
	@bash ./install_tools.sh

# Start the database container
start_db:
	@docker compose up -d postgres-container

# Run database migrations
migrate:
	@docker exec $$(docker ps --filter "name=postgres-container" --format "{{.Names}}") \
	psql -U admin -d students_db -f /migrations/schema.sql

# Build the API image
build:
	@docker compose build api-container

# Start the full environment (installs tools + starts DB + runs migrations + builds API)
run:
	@$(MAKE) install_tools
	@$(MAKE) start_db
	sleep 10  # Ensures database container is ready
	@$(MAKE) migrate
	@$(MAKE) build
	@docker compose up -d api-container
	@echo "✅ API is running at http://localhost:5000"

# Stop all running containers
stop:
	@docker compose down

# Clean containers and volumes
clean:
	@docker compose down -v
	@docker rmi $(IMAGE_NAME) || true
	@docker system prune -f
