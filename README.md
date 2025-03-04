---

### README.md  


```md
# Student Management API (Flask + PostgreSQL)

## 📌 Overview  
This is a Flask-based REST API for managing student records, using PostgreSQL as the database. The project is containerized and fully automated with a setup script (`setup.sh`), so users can easily install dependencies, set up the database, and run the application.

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
│── setup.sh    
│── create_tables.py    # this will create the table name called student if you want u can chnage this 
│── requirements.txt    # Python package dependencies
│── run.py              # Entry point to start the Flask application
│── README.md           # Project documentation
```

---

## 🚀 Getting Started  

### 1️⃣ Clone the Repository  
```bash
git clone https://github.com/gauravhalnawar1011/Portfolio-GH.git
cd SRE-Bootcamp
```

### 2️⃣ Run the Setup Script  
The `setup.sh` script will:  
- Install Python & dependencies  
- Set up PostgreSQL (or MySQL, if chosen)  
- Create a virtual environment  
- Install required Python packages  
- Initialize and migrate the database  

Run:  
```bash
chmod +x setup.sh
./setup.sh
```

> **Note:** During setup, you'll be prompted to choose a database (PostgreSQL/MySQL).  

### 3️⃣ Running the Application  
After setup, activate the virtual environment and start the Flask app:  
```bash
source venv/bin/activate
python3 run.py
```

---

## 🔗 API Endpoints  

| Method | Endpoint | Description |
|--------|---------|-------------|
| `POST` | `/api/v1/students` | Add a new student |
| `GET` | `/api/v1/students` | Retrieve all students |
| `GET` | `/api/v1/students/<id>` | Retrieve student by ID |

### Example Request (POST)  
```json
{
  "name": "One N",
  "age": 20,
  "grade": "A"
}
```
![alt text](<Screenshot from 2025-03-04 21-20-33.png>)

---

### Example Request  (GET)
```json
 {
            "age": 20,
            "grade": "A",
            "id": 3,
            "name": "One N"
}
```
![alt text](<Screenshot from 2025-03-04 21-22-07.png>)
## 🗄️ Database Setup  
By default, PostgreSQL runs in a **Docker container** on port `5433`.  

To access the database:  
```bash
psql -U admin -d students_db -h localhost -p 5433
```

---

## 🛠️ Technologies Used  
- **Flask** (Backend Framework)  
- **Flask-SQLAlchemy** (ORM)  
- **PostgreSQL** (Database)  
- **Docker** (Database containerization)  
- **Flask-Migrate** (Database migrations)  

---

