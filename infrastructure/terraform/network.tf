data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "public" {
  count = 2

  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 4, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name        = "cloud-native-devops-public-${count.index + 1}"
    Project     = "cloud-native-devops-platform"
    Environment = "demo"
    ManagedBy   = "Terraform"
    Tier        = "public"
  }
}

resource "aws_subnet" "private" {
  count = 2

  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 4, count.index + 2)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name        = "cloud-native-devops-private-${count.index + 1}"
    Project     = "cloud-native-devops-platform"
    Environment = "demo"
    ManagedBy   = "Terraform"
    Tier        = "private"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "cloud-native-devops-igw"
    Project     = "cloud-native-devops-platform"
    Environment = "demo"
    ManagedBy   = "Terraform"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name        = "cloud-native-devops-public-rt"
    Project     = "cloud-native-devops-platform"
    Environment = "demo"
    ManagedBy   = "Terraform"
  }
}

resource "aws_route_table_association" "public" {
  count = 2

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Elastic IP for NAT Gateway
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name        = "cloud-native-devops-nat-eip"
    Project     = "cloud-native-devops-platform"
    Environment = "demo"
    ManagedBy   = "Terraform"
  }
}

# NAT Gateway lives in a public subnet
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  depends_on = [
    aws_internet_gateway.main
  ]

  tags = {
    Name        = "cloud-native-devops-nat"
    Project     = "cloud-native-devops-platform"
    Environment = "demo"
    ManagedBy   = "Terraform"
  }
}

# Private route table sends internet-bound traffic through NAT
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = {
    Name        = "cloud-native-devops-private-rt"
    Project     = "cloud-native-devops-platform"
    Environment = "demo"
    ManagedBy   = "Terraform"
  }
}

resource "aws_route_table_association" "private" {
  count = 2

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
