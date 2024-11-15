
# Springboot Bank Application Deployment Guide

## Prerequisites

- AWS Account
- AWS Ubuntu EC2 instance (`t2.medium`) with:
  - **Docker** installed
  - **Docker Compose** installed
  - Necessary permissions granted

---

## Steps to Implement the Project

### Deployment Using Docker

1. **Clone the Repository**  
   ```bash
   git clone https://github.com/Faizan2727/Springboot-app.git
   ```

2. **Install Docker and Docker Compose**  
   ```bash
   sudo apt update -y
   sudo apt install docker.io docker-compose-v2 -y
   sudo usermod -aG docker $USER && newgrp docker
   ```

3. **Move to the Cloned Repository**  
   ```bash
   cd Springboot-app
   ```

4. **Build the Dockerfile**  
   ```bash
   docker build -t bankapp-mini .
   ```
   

5. **Create a Docker Network**  
   ```bash
   docker network create -d bridge bankapp
   ```

6. **Run the MySQL Container**  
   ```bash
   docker run -itd --name mysql -e MYSQL_ROOT_PASSWORD=Test@123 -e MYSQL_DATABASE=BankDB --network=bankapp mysql
   ```

7. **Run the Application Container**  
   ```bash
   docker run -itd --name BankApp -e SPRING_DATASOURCE_USERNAME="root" -e SPRING_DATASOURCE_URL="jdbc:mysql://mysql:3306/BankDB?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC" -e SPRING_DATASOURCE_PASSWORD="Test@123"  --network=bankapp -p 8080:8080 bankapp-mini
   ```

8. **Verify Deployment**  
   ```bash
   docker ps
   ```

9. **Access the Application**  
   Open port **8080** on your AWS instance's security group.  
   Access the application at:  
   `http://<public-ip>:8080`

---

### Deployment Using Docker Compose

1. **Install Docker Compose**  
   ```bash
   sudo apt update
   sudo apt install docker-compose-v2 -y
   ```

2. **Run the Docker Compose File**  
   Navigate to the root directory of the project and run:  
   ```bash
   docker compose up -d
   ```

3. **Access the Application**  
   Ensure port **8080** is open in your AWS instance's security group.  
   Access the application at:  
   `http://<public-ip>:8080`

> **Note**:  
> If you face issues with containers exiting unexpectedly, run:  
> ```bash
> docker compose down
> docker compose up -d
> ```

## Congratulations!  
You have successfully deployed the **Springboot Bank Application** . 🎉

