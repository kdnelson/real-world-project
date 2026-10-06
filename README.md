terraform init
terraform plan
terraform show
terraform state list
terraform apply -auto-approve
terraform apply --destroy
terraform destroy -auto-approve

# Recreate the deleted state bucket and file
terraform init -reconfigure