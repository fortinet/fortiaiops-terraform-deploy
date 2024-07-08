# GCP region
variable "region" {
  type    = string
  default = "us-central1" #Default Region
}

# GCP oauth access token
variable "token" {
  type    = string
  default = "<Please add your OAuth Token>"
}

# GCP zone
variable "zone" {
  type    = string
  default = "us-central1-a" #Default Zone
}

# GCP project name
variable "project" {
  type    = string
}

# GCP Fortinet official project
variable "ftntproject" {
  type    = string
  default = "fortigcp-project-001"
}

variable "image" {
  type    = string
  default = "projects/fortigcp-project-001/global/images/fortiaiops-201-build0163-lic"
}

# GCP instance machine type
variable "machine" {
  type    = string
  default = "e2-standard-4"
}

# Public Subnet CIDR
variable "public_subnet" {
  type    = string
  default = "172.16.0.0/24"
}