#!/bin/bash
set -e

echo
echo "Destroying EKS Cluster"
cd eks
terraform destroy -auto-approve

echo
echo "🧹 Cleaning up local Terraform cache..."
rm -rf .terraform .terraform.lock.hcl

echo
echo "Destroying VPC"
cd ../vpc
terraform destroy -auto-approve

echo
echo "🧹 Cleaning up local Terraform cache..."
rm -rf .terraform .terraform.lock.hcl

echo
echo "✅ EKS Cluster and VPC destroyed and cleaned up successfully!"
echo