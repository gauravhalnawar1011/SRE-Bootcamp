# 🚀 Containerized REST API with Flask & PostgreSQL (SRE Best Practices)

## 📌 Overview
This project is a containerized REST API built using Flask and PostgreSQL. It follows SRE best practices by implementing:

- **Multi-stage Docker builds** to reduce image size and improve performance.
- **Custom Docker networks** for secure and efficient communication between containers.
- **Environment variable injection** for flexible runtime configuration.
- **Automation through Makefile** to standardize and simplify common operations.
- **Robust setup automation** to minimize manual intervention and ensure reproducibility.

---

## 📂 Project Structure
```
SRE-Bootcamp/
│—— app/                # Application package
│   ├—— __init__.py     # App & database initialization
│   ├—— models.py       # Database models (Student table)
│   ├—— routes.py       # API endpoints (CRUD operations)
│   ├—— create_tables.py # Script to create database tables
│   ├—— config.py       # Database & environment configurations
│—— migrations/         # Database migration files (auto-generated)
│—— setup.sh            # Automates system dependencies, PostgreSQL, and virtualenv setup
│—— requirements.txt    # Python package dependencies
│—— run.py              # Entry point to start the Flask application
│—— Makefile            # Contains commands to build & run Docker containers
│—— Dockerfile          # Defines how to containerize the API
│—— README.md           # Project documentation
```

---

## 🛠️ Getting Started

### 1️⃣ Clone the Repository
```bash
git clone --branch Containerise_REST_API --single-branch https://github.com/gauravhalnawar1011/Portfolio-GH.git
cd SRE-Bootcamp
git pull origin Containerise_REST_API
```

### 2️⃣ Run the Setup and Containers Together


#### **Run the command:**
```bash
make run
```
![alt text](<Screenshot from 2025-03-08 18-36-05.png>)
![alt text](<Screenshot from 2025-03-08 18-36-41.png>)
This command will:
✅ Run the `setup.sh` script to handle environment setup.
✅ Build the Docker image.
✅ Start the PostgreSQL container in the correct network.
✅ Wait for PostgreSQL to be healthy before proceeding.
✅ Start the API container with the correct environment variables.

### 3️⃣ Check if PostgreSQL is Running
Verify the PostgreSQL container status:
```bash
sudo docker ps -a
```
![alt text](<Screenshot from 2025-03-08 18-34-23.png>)
If any old PostgreSQL containers are running, clean them up:
```bash
sudo docker system prune -f
```

---

## 🐳 Dockerization (Best Practices)

### **Building the Docker Image**
```bash
make build
```

### **Running the API Container**
```bash
make run
```
The API is now running at `http://localhost:5000` 🚀

---

## 💜 Makefile Automation
The **Makefile** automates repetitive Docker tasks and ensures consistency.

### **Key Makefile Commands**
```make
build:
	docker build -t $(IMAGE_NAME) .

run: build
	@echo "⏳ Waiting for PostgreSQL to be ready..."
	@until docker exec $(POSTGRES_CONTAINER) pg_isready -U admin; do sleep 3; done
	docker run -d --name $(CONTAINER_NAME) --network=$(NETWORK_NAME) -p $(PORT):$(PORT) \
		-e DATABASE_URL="postgresql://admin:admin@$(POSTGRES_CONTAINER):5432/students_db" $(IMAGE_NAME)

stop:
	docker stop $(CONTAINER_NAME) $(POSTGRES_CONTAINER) || true
	docker rm $(CONTAINER_NAME) $(POSTGRES_CONTAINER) || true

restart: stop run

logs:
	docker logs -f $(CONTAINER_NAME)

clean:
	docker rmi $(IMAGE_NAME) -f || true
	docker system prune -f
```

### **Usage Examples**
```bash
make build    # Build the Docker image
make run      # Run the API container and PostgreSQL together
make stop     # Stop and remove the containers
make restart  # Restart the containers
make logs     # View live logs
make clean    # Remove Docker images and prune system
```

---

## 📩 Postman API Testing Guide

### **Step 1:** Create a POST Request
1. Open Postman.
2. Create a **POST** request to `http://localhost:5000/api/v1/students`
3. In the **Body** tab, select **raw** and **JSON** format.
4. Enter the sample payload:
```json
{
    "name": "SRE Bootcamp Student",
    "age": 25,
    "grade": "A"
}
```
![alt text](<Screenshot from 2025-03-08 18-33-24.png>)
5. Click **Send**. You should receive a `201 Created` status.

### **Step 2:** Create a GET Request
1. Create a **GET** request to `http://localhost:5000/api/v1/students`
2. Click **Send**. You should receive a list of student records.

---
![alt text](<Screenshot from 2025-03-08 18-33-54.png>)
## 📈 Monitoring & Reliability
- Regularly inspect running containers using:
```bash
sudo docker ps -a
```
- Check PostgreSQL logs for stability:
```bash
docker logs postgres-container
```
- Ensure the database is initialized correctly with:
```bash
flask db upgrade
```

