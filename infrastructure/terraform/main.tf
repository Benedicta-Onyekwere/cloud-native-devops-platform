resource "aws_vpc" "main" {
  cidr_block           = "10.20.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "cloud-native-devops-vpc"
    Project     = "cloud-native-devops-platform"
    Environment = "demo"
    ManagedBy   = "Terraform"
  }
}
