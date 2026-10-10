# EKS Managed Node Group - Private Subnets
resource "aws_eks_node_group" "private_nodes" {
  cluster_name = aws_eks_cluster.main.name
  node_group_name = "${local.name}-private-ng"
  node_role_arn = aws_iam_role.eks_nodegroup_role.arn
  subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnet_ids
  instance_types = var.node_instance_types
  capacity_type = var.node_capacity_type
  disk_size = var.node_disk_size
  force_update_version = true

  # Use Amazon Linux 2023 AMI — the latest Amazon-managed OS optimized for EKS
  # Fully supported in Kubernetes v1.25+ and production-ready
  # Better security, updated packages, and long-term support (recommended over AL2)
  ami_type = "AL2023_x86_64_STANDARD"

  scaling_config {
    desired_size = 3
    min_size = 1
    max_size = 6
  }

  # Max percentage of nodes that can be unavailable during update
  update_config {
    max_unavailable_percentage = 33
  }

  labels = {
    "env"  = var.environment_name
    "team" = var.business_division
  }

  tags = merge(var.tags, {
    Name = "${local.name}-private-ng"
    Environment = var.environment_name
  })

  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.eks_ecr_policy
  ]
}