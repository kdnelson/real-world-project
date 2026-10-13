#!/bin/bash
set -e

echo
echo "Creating VPC"
cd vpc
terraform init 
terraform apply -auto-approve

echo
echo "Creating EKS Cluster"
cd ../eks
terraform init 
terraform apply -auto-approve

echo
echo "✅ EKS Cluster and VPC creation completed successfully!"
echo