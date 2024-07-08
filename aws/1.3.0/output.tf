
output "FortiAIOpsPublicIP" {
  value = aws_eip.FortiaiopsPublicIP.public_ip
}

output "Username" {
  value = "admin"
}
