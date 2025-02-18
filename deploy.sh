#!/bin/bash

# Áp dụng các manifest Kubernetes
kubectl apply -f frontend-deployment.yaml
kubectl apply -f frontend-service.yaml
kubectl apply -f backend-deployment.yaml
kubectl apply -f backend-service.yaml



kubectl apply -f ingress.yaml

echo "Triển khai thành công!"