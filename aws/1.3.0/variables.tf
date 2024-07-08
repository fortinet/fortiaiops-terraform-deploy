//AWS Configuration
variable "access_key" {}
variable "secret_key" {}

variable "region" {
  default = "us-east-1"
}

// Availability zones for the region
variable "az1" {
  default = "us-east-1a"
}

variable "vpccidr" {
  default = "10.1.0.0/16"
}

variable "publiccidraz1" {
  default = "10.1.0.0/24"
}

variable "arch" {
  default = "x86"
}

//Change Instance Type as per requirement and x86 supported arch
variable "size" {
  default = "t3.xlarge"
}

// Modify AMIs for FortiAIOps
variable "fortiaiopsami" {
  default = "ami-0ef40fde5ab1dfc39"
}

//  Existing SSH Key on the AWS 
variable "keyname" {
  default = "FIMG_AWS"
}
