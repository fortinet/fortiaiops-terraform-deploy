// Creating Internet Gateway
resource "aws_internet_gateway" "fortiaiopsigw" {
  vpc_id = aws_vpc.fortiaiops-vpc.id
  tags = {
    Name = "fortiaiops-igw"
  }
}

// Route Table
resource "aws_route_table" "fortiaiopspublicrt" {
  vpc_id = aws_vpc.fortiaiops-vpc.id

  tags = {
    Name = "fortiaiops-public-rt"
  }
}

resource "aws_route" "externalroute" {
  route_table_id         = aws_route_table.fortiaiopspublicrt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.fortiaiopsigw.id
}

resource "aws_route_table_association" "public1associate" {
  subnet_id      = aws_subnet.publicsubnetaz1.id
  route_table_id = aws_route_table.fortiaiopspublicrt.id
}

resource "aws_eip" "FortiaiopsPublicIP" {
  depends_on        = [aws_instance.fortiaiopsvm]
  domain            = "vpc"
  network_interface = aws_network_interface.eth0.id
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
    from_port   = 4013
    to_port     = 4013
    protocol    = "17"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 514
    to_port     = 514
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