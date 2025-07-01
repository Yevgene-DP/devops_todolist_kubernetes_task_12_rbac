#!/bin/bash
set -e

echo "⏳ Creating KIND cluster..."
kind create cluster --config cluster.yml

echo "📦 Applying manifests..."
kubectl apply -f .infrastructure/security/rbac.yml
kubectl apply -f deployment.yml

echo "⏳ Waiting for pod to be ready..."
kubectl wait --for=condition=Ready pod -l app=todoapp --timeout=60s

echo "✅ All resources deployed."


