// Create Virtual Network

resource "azurerm_virtual_network" "fortiaiopsvnetwork" {
  name                = "fortiaiopsvnet"
  address_space       = [var.vnetcidr]
  location            = var.location
  resource_group_name = azurerm_resource_group.myterraformgroup.name

  tags = {
    environment = "Fortiaiops Terraform"
  }
}

resource "azurerm_subnet" "publicsubnet" {
  name                 = "publicSubnet"
  resource_group_name  = azurerm_resource_group.myterraformgroup.name
  virtual_network_name = azurerm_virtual_network.fortiaiopsvnetwork.name
  address_prefixes     = [var.publiccidr]
}

// Allocated Public IP
resource "azurerm_public_ip" "FortiAIOpsPublicIP" {
  name                = "FortiAIOpsPublicIP"
  location            = var.location
  resource_group_name = azurerm_resource_group.myterraformgroup.name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    environment = "Fortiaiops Terraform"
  }
}

//  Network Security Group
resource "azurerm_network_security_group" "publicnetworknsg" {
  name                = "FortiAIOpsNSG"
  location            = var.location
  resource_group_name = azurerm_resource_group.myterraformgroup.name

  security_rule {
    name                       = "TCP"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Fortiaiops Terraform"
  }
}

resource "azurerm_network_security_rule" "outgoing_public" {
  name                        = "egress"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.myterraformgroup.name
  network_security_group_name = azurerm_network_security_group.publicnetworknsg.name
}

// FortiAIOps Network Interface port1
resource "azurerm_network_interface" "fortiaiopsport1" {
  name                = "fortiaiopsport1"
  location            = var.location
  resource_group_name = azurerm_resource_group.myterraformgroup.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.publicsubnet.id
    private_ip_address_allocation = "Dynamic"
    primary                       = true
    public_ip_address_id          = azurerm_public_ip.FortiAIOpsPublicIP.id
  }

  tags = {
    environment = "Fortiaiops Terraform"
  }
}

# Connect the security group to the network interfaces
resource "azurerm_network_interface_security_group_association" "port1nsg" {
  depends_on                = [azurerm_network_interface.fortiaiopsport1]
  network_interface_id      = azurerm_network_interface.fortiaiopsport1.id
  network_security_group_id = azurerm_network_security_group.publicnetworknsg.id
}

