output "ResourceGroup" {
  value = azurerm_resource_group.myterraformgroup.name
}

output "FortiAIOpsPublicIP" {
  value = format("https://%s", var.ExistingPublicIPName.name == "" ? azurerm_public_ip.FortiAIOpsPublicIP[0].ip_address : data.azurerm_public_ip.ExistingPublicIP[0].ip_address)
}