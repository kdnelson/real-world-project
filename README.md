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
# run> choco install eksctl
# run> winget install Kubernetes.kubectl
# run> Get-Command kubectl

# From the very end of the eks apply/plan:
# to_configure_kubectl = "aws eks --region us-west-2 update-kubeconfig --name retail-dev-nelson-eks"
# run> aws eks --region us-west-2 update-kubeconfig --name retail-dev-nelson-eks

# If there are any connection errors to pods, you might need to kill all processes.
# run> Stop-Process -Name "kubectl" -Force

# Validate Pod Identity Agent (PIA)
# run> kubectl get daemonset -n kube-system or kubectl get ds -n kube-system
# run> kubectl get pods -n kube-system

# run> kubectl apply -f .\kube-control
# run> kubectl version
# run> kubectl get nodes
# run> kubectl get nodes -o wide
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

# Notes:
#
# TODO:  Find a diagram for all .yaml files and how they communicate
#
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