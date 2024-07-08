resource "azurerm_image" "custom" {
  count               = var.custom ? 1 : 0
  name                = var.custom_image_name
  resource_group_name = var.custom_image_resource_group_name
  location            = var.location
  os_disk {
    os_type  = "Linux"
    os_state = "Generalized"
    blob_uri = var.customuri
  }
}

resource "azurerm_virtual_machine" "customfortiaiopsVM" {
  count                        = var.custom ? 1 : 0
  name                         = "fortiaiopsVM"
  location                     = var.location
  resource_group_name          = azurerm_resource_group.myterraformgroup.name
  network_interface_ids        = [azurerm_network_interface.fortiaiopsport1.id]
  primary_network_interface_id = azurerm_network_interface.fortiaiopsport1.id
  vm_size                      = var.size

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    id = var.custom ? element(azurerm_image.custom.*.id, 0) : null
  }

  storage_os_disk {
    name              = "osDisk"
    caching           = "ReadWrite"
    managed_disk_type = "Standard_LRS"
    create_option     = "FromImage"
  }

  # Secondary data disks
  storage_data_disk {
    name              = "fortiaiopsdatadisk"
    managed_disk_type = "Standard_LRS"
    create_option     = "Empty"
    lun               = 0
    disk_size_gb      = "500"
  }

  os_profile {
    computer_name  = "fortiaiopsVM"
    admin_username = var.adminusername
    admin_password = var.adminpassword
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  boot_diagnostics {
    enabled     = true
    storage_uri = azurerm_storage_account.fortiaiopsstorageaccount.primary_blob_endpoint
  }

  tags = {
    environment = "Terraform Deploy"
  }
}


resource "azurerm_virtual_machine" "fortiaiopsVM" {
  zones                        = [1]
  count                        = var.custom ? 0 : 1
  name                         = "fortiaiopsVM"
  location                     = var.location
  resource_group_name          = azurerm_resource_group.myterraformgroup.name
  network_interface_ids        = [azurerm_network_interface.fortiaiopsport1.id]
  primary_network_interface_id = azurerm_network_interface.fortiaiopsport1.id
  vm_size                      = var.size

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = var.publisher
    offer     = var.fortiaiopsoffer
    sku       = "fortinet_fortiaiops-vm"
    version   = var.fortiaiopsversion
  }

  plan {
    name      = "fortinet_fortiaiops-vm"
    publisher = var.publisher
    product   = var.fortiaiopsoffer
  }

  storage_os_disk {
    name              = "osDisk"
    caching           = "ReadWrite"
    managed_disk_type = "Standard_LRS"
    create_option     = "FromImage"
  }

  # Secondary data disks
  storage_data_disk {
    name              = "fortiaiopsdatadisk"
    managed_disk_type = "Standard_LRS"
    create_option     = "Empty"
    lun               = 0
    disk_size_gb      = "100"
  }

  os_profile {
    computer_name  = "fortiaiopsVM"
    admin_username = var.adminusername
    admin_password = var.adminpassword
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  boot_diagnostics {
    enabled     = true
    storage_uri = azurerm_storage_account.fortiaiopsstorageaccount.primary_blob_endpoint
  }

  tags = {
    environment = "Terraform Deploy"
  }
}
