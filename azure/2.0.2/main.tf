// Resource Group

resource "azurerm_resource_group" "myterraformgroup" {
  name     = "fortiaiops-vm-terraform"
  location = var.location

  tags = {
    environment = "Fortiaiops Terraform"
  }
}
