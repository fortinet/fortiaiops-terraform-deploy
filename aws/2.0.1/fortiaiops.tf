// FortiAIOpsVM instance

resource "aws_network_interface" "eth0" {
  description = "fortiaiops-vm-port1"
  subnet_id   = aws_subnet.publicsubnetaz1.id
}

resource "aws_network_interface_sg_attachment" "publicattachment" {
  depends_on           = [aws_network_interface.eth0]
  security_group_id    = aws_security_group.public_allow.id
  network_interface_id = aws_network_interface.eth0.id
}

resource "aws_instance" "fortiaiopsvm" {
  ami               = var.fortiaiopsami
  instance_type     = var.size
  availability_zone = var.az1
  key_name          = var.keyname

  ebs_block_device {
    device_name = "/dev/sdb"
    volume_size = "500"
    volume_type = "standard"
  }

  network_interface {
    network_interface_id = aws_network_interface.eth0.id
    device_index         = 0
  }

  tags = {
    Name = "FortiAIOpsVM"
  }
}
