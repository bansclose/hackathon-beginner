#!/bin/bash

echo "Build backend ....."
# Build image cho backend
docker build -t scofieldtt/dockerfile-backend:latest .

echo "Build frontend ...."
# Build image cho frontend
docker build -t scofieldtt/dockerfile-frontend:latest .

echo "Docker Login ...."
# Đăng nhập Docker Hubdocker login 
echo "Docker push Hub"

# Đẩy image lên Docker Hub
docker push scofieldtt/dockerfile-backend:latest
docker push scofieldtt/dockerfile-frontend:latest