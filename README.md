### 🚀 **REST API with Flask & PostgreSQL Setup Guide**

## 📌 **Overview**
This open-source project offers a containerized REST API built using Flask and PostgreSQL, now enhanced with CI/CD via GitHub Actions for seamless deployment.

Key Features:
✅ **Pre-built Docker Image** — Simply pull and run the API without complex setup  
✅ **Database Automation** — PostgreSQL container auto-creates the required `students` table  
✅ **Flexible Workflow** — Developers can customize the code and build their own Docker image  

---

## 🛠️ **Getting Started**

### 1️⃣ Prerequisites
Ensure you have the following tools installed:
- [Docker](https://docs.docker.com/get-docker/)  
- [Docker Compose](https://docs.docker.com/compose/install/)  
- [GNU Make](https://www.gnu.org/software/make/) (Optional for local development automation)  

---

### 2️⃣ **Set Up Self-Hosted GitHub Runner**
To integrate CI/CD with your GitHub repository, follow these steps:

1. **Go to Your GitHub Repository**
   - Navigate to **Settings → Actions → Runners**.
2. **Create a New Runner**
   - Click **"New self-hosted runner"** and follow the on-screen instructions.
3. **Install the Runner Locally**
   - Run the provided script on your local system to install the runner.
4. **Start the Runner**
   ```bash
   ./run.sh
   ```

---

### 3️⃣ **Storing Docker Credentials in GitHub Secrets**
For CI/CD to work securely:

1. Go to **Settings → Secrets and variables → Actions**.
2. Add the following secrets:
   - `DOCKERHUB_USERNAME`: Your Docker Hub username  
   - `DOCKERHUB_PASSWORD`: Your Docker Hub password or access token  

---

### 4️⃣ **Running the Pre-Built Docker Image**
For users who just want to run the API without modifying code:

1. **Pull the Latest Docker Image**  
```bash
docker pull gauravhalnawar0506/api-dev-env-setup-sre-bootcamp:latest
```


2. **Run the API in Detached Mode**  
```bash
docker compose up -d
```
![alt text](<Screenshot from 2025-03-10 19-48-51.png>)

3. **Verify the API is Running**  
Check running containers with:  
```bash
docker ps
```

4. **Check API Logs (Optional)**  
To view API logs in real-time:  
```bash
docker compose logs -f
```
![alt text](<Screenshot from 2025-03-10 19-51-20.png>)
---

### 5️⃣ **Making Code Changes & Building a Custom Image**
If you want to modify the code or contribute to this open-source project:

1. **Clone the Repository**  
```bash
git clone --branch feature/setup-ci-pipeline --single-branch https://github.com/gauravhalnawar1011/Portfolio-GH.git
cd SRE-Bootcamp
git pull origin feature/setup-ci-pipeline
```

2. **Make Code Changes**  
Modify files in the `/app` folder as required.

3. **Build Your Custom Docker Image**  
```bash
docker build -t your-username/custom-api:latest .
```

4. **Run Your Custom API**  
```bash
docker run -d -p 5000:5000 your-username/custom-api:latest
```

---

### 6️⃣ **CI/CD Workflow Explanation**
Our GitHub Actions workflow ensures that:

✅ Any code change triggers the pipeline  
✅ The updated Docker image is automatically built and pushed to Docker Hub  
✅ Developers can pull the latest image to access updated features instantly  

---

### 7️⃣ **Contributing to the Project**
We welcome contributions! To contribute:

- Fork the repository  
- Create a new branch: `git checkout -b feature/new-feature`  
- Commit your changes: `git commit -m "Add new feature"`  
- Push to your branch: `git push origin feature/new-feature`  
- Open a pull request for review  

---

### 📞 **Need Help?**
If you face issues while setting up the environment or running the API, feel free to raise an issue on the [GitHub repository](https://github.com/your-repository-name/issues).

---

🚀 **You're all set! Enjoy building with this Flask API.**