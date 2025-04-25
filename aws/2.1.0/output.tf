
output "FortiAIOpsPublicIP" {
  value = aws_eip.FortiAIOpsPublicIP.public_ip
}

output "Username" {
  value = "admin"
}

output "Password" {
  value = aws_instance.fortiaiops_vm.id
}

