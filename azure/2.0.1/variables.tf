// Azure configuration
variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}

variable "size" {
  type    = string
  default = "Standard_D4ds_v5"
}

// To use custom image
// by default is true
//Marketplace image yet to include
variable "custom" {
  default = true
}

//  Custom image blob uri
variable "customuri" {
  type    = string
  default = "<URL for the image blob>"
}

//  Custom image name
variable "custom_image_name" {
  type    = string
  default = "<Custom image name>"
}

//  Custom image ResourceGroup
variable "custom_image_resource_group_name" {
  type    = string
  default = "<Custome image ResourceGroup>"
}

// License Type to create FortiAIOps-VM
variable "license_type" {
  default = "byol"
}

variable "publisher" {
  type    = string
  default = "fortinet"
}

variable "fortiaiopsoffer" {
  type    = string
  default = "fortinet-fortiaiops"
}

variable "fortiaiopsversion" {
  type    = string
  default = "1.3.0"
}

variable "adminusername" {
  type    = string
  default = "azureadmin"
}

variable "adminpassword" {
  type    = string
  default = "Fortinet@123"
}

variable "location" {
  type    = string
  default = "East US"
}

variable "vnetcidr" {
  default = "10.1.0.0/16"
}

variable "publiccidr" {
  default = "10.1.0.0/24"
}