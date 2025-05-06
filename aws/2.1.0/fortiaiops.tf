resource "aws_instance" "fortiaiops_vm" {
  ami               = var.aiops-ami
  instance_type     = var.size
  availability_zone = var.az
  key_name          = var.keyname
  subnet_id = aws_subnet.fortiaiops-subnet.id
  security_groups = [ aws_security_group.public_allow.id ]

  tags = {
    Name = "FortiAIOpsVM"
  }
}
