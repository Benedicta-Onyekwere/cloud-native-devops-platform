resource "aws_ecr_repository" "app" {
  name                 = "cloud-native-devops-app"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "cloud-native-devops-app"
    Project     = "cloud-native-devops-platform"
    Environment = "demo"
    ManagedBy   = "Terraform"
  }
}
