# Define variables
APP_NAME = my_rest_api
VERSION = latest
IMAGE_NAME = $(APP_NAME):$(VERSION)

# Docker Compose commands
.PHONY: install_tools start_db migrate build run stop clean test

# Install required dependencies
install_tools:
	@bash ./install_tools.sh

# Start the database container
start_db:
	@docker compose up -d postgres-container
	@echo "⏳ Waiting for database to be ready..."
	@docker compose exec postgres-container bash -c \
		"until pg_isready -U admin; do sleep 1; done"

# Run database migrations
migrate:
	@docker exec $$(docker ps --filter "name=postgres-container" --format "{{.Names}}") \
	psql -U admin -d students_db -f /migrations/schema.sql || \
	{ echo "❌ Migration failed"; exit 1; }

# Build the API image
build:
	@docker compose build api-container

# Run tests
# test:
# 	@pip install -r requirements.txt
# 	@echo "🚨 Running tests..."
# 	pytest tests/ --disable-warnings
# Linting for code quality check
lint:
	@echo "🚨 Running linter..."
	source venv/bin/activate && flake8 app/ 
	
# Start the full environment (installs tools + starts DB + runs migrations + builds API)
run: install_tools start_db migrate build
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
