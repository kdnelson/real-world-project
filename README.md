# terraform Commands:

terraform init
terraform plan
terraform show
terraform state list
terraform apply -auto-approve
terraform apply --destroy
terraform destroy -auto-approve

# Run Directions:
#
# Create the vpc with the same named terraform folder
# Create the eks with the same named terraform folder
# Destroy in the opposite order
# Or, just run these shell scripts
# run> & "C:\Program Files\Git\bin\bash.exe" .\create-cluster.sh
# run> & "C:\Program Files\Git\bin\bash.exe" .\destroy-cluster.sh

# You might need to install:
#
# run> choco install eksctl
# run> winget install Kubernetes.kubectl
# run> Get-Command kubectl

# From the very end of the eks apply/plan (TODO: Can this be automated with destroy too?):
# to_configure_kubectl = "aws eks --region us-west-2 update-kubeconfig --name retail-dev-nelson-eks"
# run> aws eks --region us-west-2 update-kubeconfig --name retail-dev-nelson-eks
# run> kubectl apply -f .\kube
# run> kubectl version
# run> kubectl get nodes
# run> kubectl get nodes -o wide

# Install Helm:
#
# run> choco install kubernetes-helm
# run> helm version
# run> helm repo add secrets-store-csi-driver https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts
# run> helm repo add aws-secrets-manager https://aws.github.io/secrets-store-csi-driver-provider-aws
# run> helm repo update
# run> helm repo list
# run> helm install csi-secrets-store `
  secrets-store-csi-driver/secrets-store-csi-driver `
  --namespace kube-system `
  --set "tokenRequests[0].audience=pods.eks.amazonaws.com"
# run> helm list --all-namespaces
# run> helm list -n kube-system
# run> helm status csi-secrets-store -n kube-system
# run> kubectl get pods -n kube-system -l app=secrets-store-csi-driver
# run helm install secrets-provider-aws `
  aws-secrets-manager/secrets-store-csi-driver-provider-aws `
  --namespace kube-system `
  --set "secrets-store-csi-driver.install=false"
# run> helm list -n kube-system
# run> helm status secrets-provider-aws -n kube-system
# run> kubectl get pods -n kube-system -l app=secrets-store-csi-driver
# run> kubectl get pods -n kube-system -l app=secrets-store-csi-driver-provider-aws
# run> kubectl get daemonset -n kube-system | Select-String "secrets-store"
# run> kubectl describe daemonset secrets-provider-aws-secrets-store-csi-driver-provider-aws -n kube-system
# run> kubectl logs -n kube-system -l app=secrets-store-csi-driver-provider-aws
# run> kubectl get pods -n kube-system -l "app.kubernetes.io/instance in (csi-secrets-store, secrets-provider-aws)"

# To validate Pod Identity Agent (PIA):
# run> $AWS_REGION="us-west-2"
$CLUSTER_NAME="retail-dev-nelson-eks"

aws eks create-pod-identity-association --cluster-name $CLUSTER_NAME --namespace default --service-account catalog-mysql-sa --role-arn "arn:aws:iam::824333227939:role/catalog-db-secrets-role" --region $AWS_REGION
# run> kubectl get daemonset -n kube-system or kubectl get ds -n kube-system
# run> kubectl get pods -n kube-system

# Create some secrets and daemonset:
#
# run> aws secretsmanager put-secret-value --secret-id catalog-db-secret-1 --region $env:AWS_REGION --secret-string '{"MYSQL_USER":"mydbadmin","MYSQL_PASSWORD":"kalyandb101"}'
# run> $AWS_REGION="us-west-2"  # Replace with your actual region
aws secretsmanager list-secrets --region $AWS_REGION --query "SecretList[?contains(Name, 'catalog-db-secret-1')].[Name,ARN]" --output table
# run> aws secretsmanager describe-secret `
--secret-id catalog-db-secret-1 `
--region $AWS_REGION
# run> aws secretsmanager get-secret-value --secret-id catalog-db-secret-1 --region $AWS_REGION --query SecretString --output text
# run> aws ec2 create-vpc-endpoint --vpc-id vpc-0bd9a85748297baac --vpc-endpoint-type Interface --service-name com.amazonaws.us-west-2.secretsmanager --subnet-ids subnet-058f49d8455463769 subnet-0542c4267fe67d02a subnet-0d76dd2a43b57278b --security-group-ids sg-0a24f18e39d7aac67 --private-dns-enabled
# run> aws eks create-addon --cluster-name retail-dev-nelson-eks --addon-name eks-pod-identity-agent --region us-west-2
# run> kubectl get daemonset eks-pod-identity-agent -n kube-system
# run> kubectl get daemonset -n kube-system | sls secrets-store
# run> kubectl get pods -n kube-system -l "app.kubernetes.io/name=aws-ebs-csi-driver"
# run> aws eks list-addons --cluster-name ${EKS_CLUSTER_NAME}
aws eks create-addon `
--cluster-name ${EKS_CLUSTER_NAME} `
--addon-name aws-ebs-csi-driver `
--service-account-role-arn arn:aws:iam::${AWS_ACCOUNT_ID}:role/AmazonEKS_EBS_CSI_DriverRole_${EKS_CLUSTER_NAME}




# Extra commands:
#
# run> kubectl get namespaces
# run> kubectl get all -n kube-system
# run> kubectl get ds -n kube-system
# run> kubectl describe pod
# run> kubectl logs -f catalog-pod
# run> kubectl delete pod catalog-pod
# run> kubectl get sts
# run> kubectl logs -f deploy/catalog
# run> kubectl get deployment
# run> kubectl rollout status deployment/catalog
# run> kubectl kubectl get pods
# run> kubectl describe pod <podname-from-get-pods-printout>
# run> kubectl describe deploy catalog
# rs = ReplicaSet
# run> kubectl get rs
# Access the pod by port-forwarding
# run> kubectl port-forward deployment/catalog 7080:8080
# Goto browser: http://localhost:7080/health -> OK
# Goto browser: http://localhost:7080/catalog/products -> JSON blob
# Scale your deployment of pods
# run> kubectl get pods -> shows 1 pod
# run> kubectl scale deployment catalog --replicas=3
# run> kubectl get pods -> shows 3 pods
# Delete entire deployment, versions, and history
# run> kubectl delete -f .\deployment.yaml
# run> kubectl apply -f .\cluster-ip.yaml
# run> kubectl get svc
# run> kubectl get endpointslices

# If there are any connection errors to pods, you might need to kill all processes:
# run> Stop-Process -Name "kubectl" -Force
# run> kubectl rollout restart deployment/catalog

# Notes:
#
Nodes are EC2 machines, and pods are the smallest peice of software that can be installed on them.
PS C:\Users\krisd\GitHub\real-world-project> kubectl get nodes
NAME                                       STATUS   ROLES    AGE    VERSION
ip-10-0-10-87.us-west-2.compute.internal   Ready    <none>   2d3h   v1.37.0-eks-b9510e3
ip-10-0-11-34.us-west-2.compute.internal   Ready    <none>   2d3h   v1.37.0-eks-b9510e3
ip-10-0-12-83.us-west-2.compute.internal   Ready    <none>   2d3h   v1.37.0-eks-b9510e3
PS C:\Users\krisd\GitHub\real-world-project> kubectl get pods -n kube-system -l "app.kubernetes.io/name=aws-ebs-csi-driver"
NAME                                  READY   STATUS    RESTARTS   AGE
ebs-csi-controller-7f54d7459d-jfrcp   6/6     Running   0          16m
ebs-csi-controller-7f54d7459d-lzzv4   6/6     Running   0          16m
ebs-csi-node-jfgsk                    3/3     Running   0          16m
ebs-csi-node-qp9r2                    3/3     Running   0          16m
ebs-csi-node-vkf9z                    3/3     Running   0          16m
#
# TODO: 
# Find a diagram for all .yaml files and how they communicate
# Pods are spread accross worker nodes within your EKS cluster
# You could run multiple containers per pod, but not recommended.  There are some 
# situations when it might be a good idea though.
# Each pod run a copy of your container, containing your docker image
# Each pod will be versioned with a podSpec
# Every endpoint listed under 'readinessProbe:' within your pod.yaml will get called 
# every second.  Typically, a health endpoint check is added to this section, but other endpoints
# can be added too.  Also, health endpoints are skipped in the logging.
# Pods can be brought off-line or "drained" because of OS upgrades, scaling, or Spot
# interuptions.  When pods are managed with a "Replica count", another pod will be spawned
# Pods should never be created independantly.  Instead, use either deploymwent job or replicaSet
# EKS workflow: Deployment -> ReplicaSet -> Pods
# Deployment revisions allow for roll-back and self-healing of pods
# Pod names are dynamically created, never static
# Pods can be stateful or stateless.  For a master-slaver architecure, you need to use StatefulSet
# Cluster-Ip can't handle master-slave architecures
# Headless Service allows pods to be accessed directly by way of DNS name
# To create a headless service form a Cluster-Ip - define as cluster-ip:none
# StatefulSets scale up and down the pods in an ordered fashion