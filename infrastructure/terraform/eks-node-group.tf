resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "cloud-native-devops-workers"
  node_role_arn   = aws_iam_role.eks_node.arn

  subnet_ids = [
    aws_subnet.private[0].id,
    aws_subnet.private[1].id
  ]

  instance_types = ["t3.small"]

  scaling_config {
    desired_size = 2
    min_size     = 1
    max_size     = 2
  }

  labels = {
    Environment = "demo"
    Project     = "cloud-native-devops-platform"
  }

  tags = {
    Name        = "cloud-native-devops-worker"
    Project     = "cloud-native-devops-platform"
    Environment = "demo"
    ManagedBy   = "Terraform"
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.eks_ecr_read_only
  ]
}
