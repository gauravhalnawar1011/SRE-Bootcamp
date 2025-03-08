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
│── app/                # Application package
│   ├── __init__.py     # App & database initialization
│   ├── models.py       # Database models (Student table)
│   ├── routes.py       # API endpoints (CRUD operations)
│   ├── create_tables.py # Script to create database tables
│   ├── config.py       # Database & environment configurations
│── migrations/         # Database migration files (auto-generated)
│── setup.sh            # Automates system dependencies, PostgreSQL, and virtualenv setup
│── requirements.txt    # Python package dependencies
│── run.py              # Entry point to start the Flask application
│── Makefile            # Contains commands to build & run Docker containers
│── Dockerfile          # Defines how to containerize the API
│── README.md           # Project documentation
```

---

## 🛠️ Getting Started

### 1️⃣ Clone the Repository
```bash
git clone --branch Containerise_REST_API --single-branch https://github.com/gauravhalnawar1011/Portfolio-GH.git
cd SRE-Bootcamp
git pull origin Containerise_REST_API
```

### 2️⃣ Run the Setup Script
The `setup.sh` script automates the following:
✅ Updates system packages
✅ Installs dependencies (Python, pip, venv, Docker)
✅ Sets up PostgreSQL in a Docker container
✅ Configures a custom Docker network (`my_network`)
✅ Creates & activates a Python virtual environment
✅ Installs required Python packages from `requirements.txt`
✅ Runs Flask database migrations

#### **Run the script:**
```bash
chmod +x setup.sh
./setup.sh
```

### 3️⃣ Check if PostgreSQL is Running
Verify the PostgreSQL container status:
```bash
sudo docker ps -a
```
If any old PostgreSQL containers are running, clean them up:
```bash
sudo docker system prune -f
```

---

## 🐳 Dockerization (Best Practices)

### **Building the Docker Image**
```bash
docker build -t my_rest_api:1.0.0 .
```
> **Why versioning instead of `latest`?**
- Using semantic versioning (`1.0.0`, `1.0.1`) ensures better traceability.
- Avoids unexpected behavior from `latest` images.

### **Running the API Container**
```bash
docker run -d --name my_api_container --network=my_network -p 5000:5000 \
  -e DATABASE_URL="postgresql://admin:admin@postgres-container:5432/students_db" my_rest_api:1.0.0
```
The API is now running at `http://localhost:5000` 🚀

---

## 📜 Makefile Automation
The **Makefile** automates repetitive Docker tasks and ensures consistency.

### **Key Makefile Commands**
```make
build:
	docker build -t $(IMAGE_NAME) .

run: build
	docker run -d --name $(CONTAINER_NAME) --network=$(NETWORK_NAME) -p $(PORT):$(PORT) \
		-e DATABASE_URL="postgresql://admin:admin@$(POSTGRES_CONTAINER):5432/students_db" $(IMAGE_NAME)

stop:
	docker stop $(CONTAINER_NAME) || true
	docker rm $(CONTAINER_NAME) || true

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
make run      # Run the API container
make stop     # Stop and remove the container
make restart  # Restart the container
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
/home/gauravhalnawar/Pictures/Screenshots/Screenshot from 2025-03-06 13-42-59.png
5. Click **Send**. You should receive a `201 Created` status.

### **Step 2:** Create a GET Request
1. Create a **GET** request to `http://localhost:5000/api/v1/students`
2. Click **Send**. You should receive a list of student records.
![alt text](<Screenshot from 2025-03-06 13-43-12-1.png>)

### **Step 3:** Error Handling in Postman
- **400 Bad Request** → Check your JSON payload format.
- **500 Internal Server Error** → Ensure the PostgreSQL container is running.

---

## 🎯 Key Learning Outcomes
✅ **Dockerizing a Flask API** using a well-structured Dockerfile
✅ **Multi-stage builds** to optimize image size
✅ **Custom networks** to enable container-to-container communication
✅ **Injecting environment variables** at runtime
✅ **Using Makefile for automation**
✅ **Postman API testing with structured steps**

---

## 📸 Screenshots (Proof of Execution)
✅ PostgreSQL container running
![alt text](<Screenshot from 2025-03-06 13-19-36.png>)
![alt text](<Screenshot from 2025-03-06 13-42-07.png>)
✅ Successful API requests in Postman
![alt text](<Screenshot from 2025-03-06 13-42-59-1.png>)
![alt text](<Screenshot from 2025-03-06 13-43-12-2.png>)
![alt text](<Screenshot from 2025-03-06 13-44-50.png>)
![alt text](<Screenshot from 2025-03-06 12-57-30.png>)
![alt text](<Screenshot from 2025-03-06 13-14-06.png>)
![alt text](<Screenshot from 2025-03-06 13-19-06.png>)
✅ make build and setup.sh 
![alt text](<Screenshot from 2025-03-06 13-38-23.png>)
![alt text](<Screenshot from 2025-03-06 13-38-40.png>)
---

## 🔍 Monitoring & Reliability
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

---



