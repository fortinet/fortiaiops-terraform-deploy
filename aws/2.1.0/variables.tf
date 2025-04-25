//AWS Configuration
variable "access_key" {}
variable "secret_key" {}

variable "region" {
  default = "us-east-1"
}

// Availability zones for the region
variable "az" {
  default = "us-east-1a"
}

variable "vpccidr" {
  default = "10.1.0.0/16"
}

variable "public_cidr" {
  default = "10.1.0.0/24"
}

variable "size" {
  default = "c5.4xlarge"
}

// AMIs for FortiAIOps 2.1.0
variable "aiops-ami" {
  type = string
  default = "ami-07523e12e5e80c85c"
}

//  Existing SSH Key on the AWS 
variable "keyname" {
  default = "<AWS SSH KEY>"
}
