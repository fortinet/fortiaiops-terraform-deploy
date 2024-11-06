####################################
## NETWORK SETTINGS              ##
###################################


resource "oci_core_virtual_network" "my_vcn" {
  cidr_block     = var.vcn_cidr
  compartment_id = var.compartment_ocid
  display_name   = "fortiaiops-vcn"
  dns_label      = "fortiaiopsvcn"
}

resource "oci_core_internet_gateway" "igw" {
  compartment_id = var.compartment_ocid
  display_name   = "fortiaiops-igw"
  vcn_id         = oci_core_virtual_network.my_vcn.id
}

resource "oci_core_route_table" "public_routetable" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.my_vcn.id
  display_name   = "fortiaiops-public-rt"

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.igw.id
  }
}

resource "oci_core_subnet" "public_subnet" {
  availability_domain = lookup(data.oci_identity_availability_domains.ads.availability_domains[var.availability_domain - 1], "name")
  cidr_block          = var.public_subnet_cidr
  display_name        = "fortiaiops-subnet"
  compartment_id      = var.compartment_ocid
  vcn_id              = oci_core_virtual_network.my_vcn.id
  route_table_id      = oci_core_route_table.public_routetable.id
  security_list_ids   = ["${oci_core_virtual_network.my_vcn.default_security_list_id}", "${oci_core_security_list.public_security_list.id}"]
  dhcp_options_id     = oci_core_virtual_network.my_vcn.default_dhcp_options_id
  dns_label           = "faiopsPublic"
}

resource "oci_core_security_list" "public_security_list" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.my_vcn.id
  display_name   = "fortiaiops-public-security-list"

  // allow outbound tcp traffic on all ports
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
  }

  // allow inbound http (port 443) traffic
  ingress_security_rules {
    protocol = "6" // tcp
    source   = "0.0.0.0/0"

    tcp_options {
      min = 443
      max = 443
    }
  }

  // allow inbound ssh traffic
  ingress_security_rules {
    protocol  = "6" // tcp
    source    = "0.0.0.0/0"
    stateless = false

    tcp_options {
      min = 22
      max = 22
    }
  }

  // allow inbound (port 514) traffic
  ingress_security_rules {
    protocol  = "17" // udp
    source    = "0.0.0.0/0"
    stateless = false

    udp_options {
      min = 514
      max = 514
    }
  }

  // allow inbound (port 4013) traffic
  ingress_security_rules {
    protocol  = "17" // udp
    source    = "0.0.0.0/0"
    stateless = false

    udp_options {
      min = 4013
      max = 4013
    }
  }
  // allow inbound icmp traffic of a specific type
  ingress_security_rules {
    protocol = 1
    source   = "0.0.0.0/0"
  }
}

// create FortiAIOps instance
resource "oci_core_instance" "vm" {
  depends_on          = [oci_core_internet_gateway.igw]
  availability_domain = lookup(data.oci_identity_availability_domains.ads.availability_domains[var.availability_domain - 1], "name")
  compartment_id      = var.compartment_ocid
  display_name        = "fortiaiops-vm"
  shape               = var.instance_shape


  shape_config {
    ocpus         = var.instance_cpu
    memory_in_gbs = var.instance_memory
  }

  create_vnic_details {
    subnet_id        = oci_core_subnet.public_subnet.id
    display_name     = "fortiaiops-vnic"
    assign_public_ip = true
    hostname_label   = "fortiaiops-vnic"
  }

  launch_options {
    network_type = "PARAVIRTUALIZED"
  }

  source_details {
    source_type             = "image"
    source_id               = local.app_listing_resource_id // marketplace listing
    boot_volume_size_in_gbs = "50"
  }

  timeouts {
    create = "60m"
  }
}
