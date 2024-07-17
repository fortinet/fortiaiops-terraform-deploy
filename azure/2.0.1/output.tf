output "ResourceGroup" {
  value = azurerm_resource_group.myterraformgroup.name
}

output "FortiAIOpsPublicIP" {
  value = format("https://%s", azurerm_public_ip.FortiAIOpsPublicIP.ip_address)
}

