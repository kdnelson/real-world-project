#!/bin/bash
set -e

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE}")/.." && pwd)"

echo
echo "Destroying EKS Cluster"
echo
cd "$PROJECT_ROOT/eks"
terraform destroy -auto-approve
rm -rf .terraform .terraform.lock.hcl

echo
echo "Destroying VPC"
echo
cd "$PROJECT_ROOT/vpc"
terraform destroy -auto-approve
rm -rf .terraform .terraform.lock.hcl

# Optional: Cleans up the root state file if it exists
if [ -f "$PROJECT_ROOT/terraform.tfstate" ]; then
    echo "🧹 Cleaning up accidental root state file..."
    rm -f "$PROJECT_ROOT/terraform.tfstate" "$PROJECT_ROOT/terraform.tfstate.backup"
fi