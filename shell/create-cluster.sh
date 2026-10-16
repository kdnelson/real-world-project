#!/bin/bash
set -e

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE}")/.." && pwd)"

echo
echo "Creating VPC"
echo
cd "$PROJECT_ROOT/vpc"
terraform init 
terraform apply -auto-approve

echo
echo "Creating EKS Cluster"
echo
cd "$PROJECT_ROOT/eks"
terraform init 
terraform apply -auto-approve

echo "✅ EKS Cluster and VPC creation completed successfully!"
echo