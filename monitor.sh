#!/bin/bash

# Function to check if containers are running
check_containers() {
    if ! docker-compose ps | grep -q "Up"; then
        echo "Containers are down. Recreating..."
        docker-compose up -d
    else
        echo "Containers are running normally."
    fi
}

# Initial startup
docker-compose up -d

# Monitor containers every 30 seconds
while true; do
    check_containers
    sleep 30
done 