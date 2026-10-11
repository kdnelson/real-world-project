terraform init
terraform plan
terraform show
terraform state list
terraform apply -auto-approve
terraform apply --destroy
terraform destroy -auto-approve

# Config kubeCTL/eksctl:
#
# run> choco install eksctl
# run> winget install Kubernetes.kubectl
# run> Get-Command kubectl
# From the very end of the eks apply/plan:
# to_configure_kubectl = "aws eks --region us-west-2 update-kubeconfig --name retail-dev-nelson-eks"
# run> aws eks --region us-west-2 update-kubeconfig --name retail-dev-nelson-eks
# run> kubectl version
# run> kubectl get nodes
# run> kubectl get nodes -o wide
# run> kubectl get namespaces
# run> kubectl get all -n kube-system
# run> kubectl get ds -n kube-system