# Flask E-commerce Application Deployment Guide

This guide provides step-by-step instructions for deploying the Flask E-commerce application using Docker and setting up automatic container management on both Ubuntu and Windows environments.

## Table of Contents
- [Prerequisites](#prerequisites)
- [Installation](#installation)
  - [Ubuntu Setup](#ubuntu-setup)
  - [Windows Setup](#windows-setup)
- [Docker Configuration](#docker-configuration)
- [Automatic Container Management](#automatic-container-management)
- [Backup System](#backup-system)
- [Monitoring and Maintenance](#monitoring-and-maintenance)
- [Security Considerations](#security-considerations)
- [Troubleshooting](#troubleshooting)

## Prerequisites

### Ubuntu Requirements
```bash
# Update system packages
sudo apt update
sudo apt upgrade -y

# Install required packages
sudo apt install -y docker.io docker-compose git
```

### Windows Requirements
- Install [Docker Desktop for Windows](https://www.docker.com/products/docker-desktop)
- Enable WSL 2 (Windows Subsystem for Linux)
- Git for Windows

## Installation

### Ubuntu Setup

1. **Setup Docker**
```bash
# Add current user to docker group
sudo usermod -aG docker $USER

# Apply group changes
newgrp docker

# Start and enable Docker service
sudo systemctl start docker
sudo systemctl enable docker
```

2. **Clone Repository**
```bash
# Create project directory
mkdir ~/flask-ecommerce
cd ~/flask-ecommerce

# Clone the repository
git clone https://github.com/yourusername/Flask-Ecommerce.git .
```

3. **Setup Monitoring Service**
```bash
# Make monitor script executable
chmod +x monitor.sh

# Configure systemd service
sudo cp flask-ecommerce.service /etc/systemd/system/
sudo sed -i "s|/path/to/your|$PWD|g" /etc/systemd/system/flask-ecommerce.service

# Reload systemd and start service
sudo systemctl daemon-reload
sudo systemctl enable flask-ecommerce
sudo systemctl start flask-ecommerce
```

### Windows Setup

1. **Start Docker Desktop**
   - Launch Docker Desktop
   - Wait for the Docker engine to start
   - Ensure WSL 2 integration is enabled

2. **Clone and Setup**
```powershell
# Clone repository
git clone https://github.com/yourusername/Flask-Ecommerce.git
cd Flask-Ecommerce

# Start containers
docker-compose up -d
```

## Docker Configuration

The application uses three main components:
- Web Application (Flask)
- Database (PostgreSQL)
- Volume Management

### Container Structure
```yaml
services:
  web:
    - Port: 8000
    - Auto-restart: Enabled
    - Health checks: Every 30s
  
  db:
    - PostgreSQL 13
    - Persistent storage
    - Auto-backup enabled
```

### Starting the Application
```bash
# Build and start containers
docker-compose up -d

# View logs
docker-compose logs -f

# Stop containers
docker-compose down
```

## Automatic Container Management

### Monitor Script (Ubuntu)
The `monitor.sh` script provides automatic container management:
- Checks container status every 30 seconds
- Automatically recreates failed containers
- Logs all actions

### Usage
```bash
# Check monitor service status
sudo systemctl status flask-ecommerce

# View monitor logs
sudo journalctl -u flask-ecommerce -f
```

## Backup System

### Automated Backups
The system includes automated backup functionality:
- Daily database backups
- Volume data backups
- 7-day retention policy

### Setup Backup System
```bash
# Make backup script executable
sudo chmod +x backup-ecommerce.sh

# Setup daily cron job (runs at 2 AM)
(crontab -l 2>/dev/null; echo "0 2 * * * /path/to/backup-ecommerce.sh") | crontab -
```

### Backup Locations
- Database: `/var/backups/flask-ecommerce/db_backup_*.sql`
- Static files: `/var/backups/flask-ecommerce/static_backup_*.tar.gz`
- Media files: `/var/backups/flask-ecommerce/media_backup_*.tar.gz`

## Monitoring and Maintenance

### Health Checks
- Web application: HTTP check on /health endpoint
- Database: PostgreSQL connection test
- Automatic recovery on failure

### Common Commands
```bash
# View container status
docker ps

# Check container logs
docker-compose logs -f [service_name]

# Restart specific service
docker-compose restart [service_name]

# View system service status (Ubuntu)
sudo systemctl status flask-ecommerce
```

## Security Considerations

### Firewall Setup (Ubuntu)
```bash
# Install UFW
sudo apt install ufw

# Configure rules
sudo ufw allow ssh
sudo ufw allow 8000
sudo ufw enable
```

### Database Security
- Change default passwords in `docker-compose.yml`
- Regular security updates
- Automated backups

## Troubleshooting

### Common Issues

1. **Containers not starting**
```bash
# Check logs
docker-compose logs

# Verify Docker service
sudo systemctl status docker
```

2. **Database connection issues**
```bash
# Check database logs
docker-compose logs db

# Verify network connectivity
docker network ls
```

3. **Monitor service not running (Ubuntu)**
```bash
# Check service status
sudo systemctl status flask-ecommerce

# Review logs
sudo journalctl -u flask-ecommerce -f
```

### Getting Help
- Check the logs using `docker-compose logs`
- Review service status with `systemctl status`
- Consult the Docker documentation
- Open an issue on the project repository

## License
[Include your license information here]

## Contributing
[Include contribution guidelines here]

## 🐱‍🏍✨Flask E-commerce Application with Gunicorn✨🐱‍🏍

🐍Python Project🐍

📌Customers can sign in or sign up
📌Customers can reset their passwords
📌Customers can search for goods
📌Add them to their cart
📌Payment Gateway Functionality
📌Admins can regulate shop products e.g stock level
📌Admins can change order status


OVERVIEW

This Docker image packages a Flask-based e-commerce application, optimized for production use with Gunicorn. The lightweight python:3.8-slim base image ensures efficient and quick deployment.

FEATURES

Flask Framework: Robust and scalable web application built with Flask.
Gunicorn Server: High-performance WSGI server for running Python web applications.
Efficient: Slim Python base image minimizes overhead.

HOW TO USE 

docker pull monish247/ecommerce_python_image:latest   

docker run -itd -p 8034:80 monish247/ecommerce_python_image:latest

