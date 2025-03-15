#!/bin/bash

BACKUP_DIR="/var/backups/flask-ecommerce"
DATE=$(date +%Y%m%d_%H%M%S)

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Backup PostgreSQL database
docker-compose exec -T db pg_dump -U postgres ecommerce > $BACKUP_DIR/db_backup_$DATE.sql

# Backup volumes
tar -czf $BACKUP_DIR/static_backup_$DATE.tar.gz -C /var/lib/docker/volumes/flask-ecommerce-main_static_volume/_data .
tar -czf $BACKUP_DIR/media_backup_$DATE.tar.gz -C /var/lib/docker/volumes/flask-ecommerce-main_media_volume/_data .

# Keep only last 7 days of backups
find $BACKUP_DIR -name "*.sql" -mtime +7 -delete
find $BACKUP_DIR -name "*.tar.gz" -mtime +7 -delete 