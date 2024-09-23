// Azure configuration
variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}

variable "size" {
  type    = string
  default = "Standard_E4as_v5"
}

// To use custom image
// by default is true
//Marketplace image yet to include
variable "custom" {
  default = false
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

//  Select Custome image disk type for custom image, Eg, Standard_LRS, StandardSSD_LRS
variable "storageType" {
  type    = string
  default = "<Custome image disk type>"
}

//  Select existing ResourceGroup to store Custom image ResourceGroup
variable "custom_image_resource_group_name" {
  type    = string
  default = "<Custome image ResourceGroup>"
}

//  Please provied the Existing PublicIP name and ResourceGroup in same region if any, by default new PublicIP will be created if not changed.
variable "ExistingPublicIPName" {
  type    = map(string)
  default = {
    name = ""
    ResourceGroup = ""
  }
}

//  Secondary Disk size
variable "SecondaryDisk" {
  type    = number
  default = "500"
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
  default = "2.0.2"
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