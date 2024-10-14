// OCI configuration
variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "private_key_path" {}
variable "fingerprint" {}
variable "compartment_ocid" {}
variable "region" {}

variable "app_listing_id" {
  default = "ocid1.appcataloglisting.oc1..aaaaaaaaqh4tet7fksyud7xswxwse34ybeo4bttqxchr2ley54ufiunnvpqa" //2.1.0
}

variable "app_listing_resource_id" {
  default = "ocid1.image.oc1..aaaaaaaa4x6khqkppnyxoromnjbw4d2d4o6q4ywo44ijeckg5ttfzlizylea" //2.1.0
}

// Version
variable "app_listing_resource_version" {
  default = "2.1.0"
}

// Environment configuration
variable "vcn_cidr" {
  type    = string
  default = "10.1.0.0/16"
}

variable "public_subnet_cidr" {
  type    = string
  default = "10.1.0.0/24"
}

variable "x86" {
  type    = bool
  default = true
}

// instance shape
variable "instance_shape" {
  type    = string
  default = "VM.Standard.E4.Flex" //x86
}

// instance cpu
variable "instance_cpu" {
  type    = string
  default = "2"
}

// instance memory
variable "instance_memory" {
  type    = string
  default = "32"
}

# Choose an Availability Domain (1,2,3)
variable "availability_domain" {
  type    = string
  default = "1"
}

variable "volume_size" {
  type    = string
  default = "500" //GB; Secondary Data Disk
}
