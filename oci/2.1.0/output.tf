//  Output
output "Default_Username" {
  value = "admin"
}

output "PublicIP" {
  value = oci_core_instance.vm.*.public_ip
}


