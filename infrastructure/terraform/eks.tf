resource "aws_eks_cluster" "main" {
  name     = "cloud-native-devops-eks"
  role_arn = aws_iam_role.eks_cluster.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.private[0].id,
      aws_subnet.private[1].id
    ]

    endpoint_private_access = true
    endpoint_public_access  = true
  }

  tags = {
    Project     = "cloud-native-devops-platform"
    Environment = "demo"
    ManagedBy   = "Terraform"
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy
  ]
}
