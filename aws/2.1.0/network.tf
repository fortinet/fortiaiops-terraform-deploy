// AWS VPC 
resource "aws_vpc" "fortiaiops-vpc" {
  cidr_block           = var.vpccidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"
  tags = {
    Name = "fortiaiops vpc"
  }
}

resource "aws_subnet" "fortiaiops-subnet" {
  vpc_id            = aws_vpc.fortiaiops-vpc.id
  cidr_block        = var.public_cidr
  availability_zone = var.az
  tags = {
    Name = "fortiaiops subnet"
  }
}

// Creating Internet Gateway
resource "aws_internet_gateway" "aiops_igw" {
  vpc_id = aws_vpc.fortiaiops-vpc.id
  tags = {
    Name = "aiops-igw"
  }
}

// Route Table
resource "aws_route_table" "aiops-rt" {
  vpc_id = aws_vpc.fortiaiops-vpc.id

  tags = {
    Name = "aiops-rt"
  }
}

resource "aws_route" "externalroute" {
  route_table_id         = aws_route_table.aiops-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.aiops_igw.id
}

resource "aws_route_table_association" "route_associate" {
  subnet_id      = aws_subnet.fortiaiops-subnet.id
  route_table_id = aws_route_table.aiops-rt.id
}

resource "aws_eip" "FortiAIOpsPublicIP" {
  instance = aws_instance.fortiaiops_vm.id
  domain            = "vpc"
}

// Security Group

resource "aws_security_group" "public_allow" {
  name        = "Public Allow"
  description = "Public Allow traffic"
  vpc_id      = aws_vpc.fortiaiops-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "6"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 514
    to_port     = 514
    protocol    = "17"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 4013
    to_port     = 4013
    protocol    = "17"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Public Allow"
  }
}