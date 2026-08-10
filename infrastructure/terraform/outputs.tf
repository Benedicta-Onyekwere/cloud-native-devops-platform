output "aws_region" {
  description = "AWS region used by Terraform"
  value       = var.aws_region
}

output "vpc_id" {
  description = "ID of the Terraform-managed AWS VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "CIDR block of the AWS VPC"
  value       = aws_vpc.main.cidr_block
}
output "ecr_repository_url" {
  description = "URL of the Amazon ECR repository"
  value       = aws_ecr_repository.app.repository_url
}
output "eks_cluster_name" {
  description = "Name of the AWS EKS cluster"
  value       = aws_eks_cluster.main.name
}

output "eks_cluster_endpoint" {
  description = "API endpoint of the AWS EKS cluster"
  value       = aws_eks_cluster.main.endpoint
}
