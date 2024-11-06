### GCP terraform
terraform {
  required_version = ">=1.0.0"
  required_providers {
    google      = ">=2.11.0"
    google-beta = ">=2.13"
  }
}
provider "google" {
  project      = var.project
  region       = var.region
  zone         = var.zone
  access_token = var.token
}
provider "google-beta" {
  project      = var.project
  region       = var.region
  zone         = var.zone
  access_token = var.token
}

# Randomize string to avoid duplication
resource "random_string" "random_name_post" {
  length           = 3
  special          = true
  override_special = ""
  min_lower        = 3
}

# Create data disk
resource "google_compute_disk" "datadisk" {
  name = "data-disk-${random_string.random_name_post.result}"
  size = var.SecondaryDiskSize
  type = "pd-standard"
  zone = var.zone
}


### VPC ###
resource "google_compute_network" "vpc_network" {
  name                    = "vpc-public-${random_string.random_name_post.result}"
  auto_create_subnetworks = false
}

### Public Subnet ###
resource "google_compute_subnetwork" "public_subnet" {
  name                     = "public-subnet-${random_string.random_name_post.result}"
  region                   = var.region
  network                  = google_compute_network.vpc_network.name
  ip_cidr_range            = var.public_subnet
  private_ip_google_access = true
}

# Firewall Rule External
resource "google_compute_firewall" "allow-fortiaiops" {
  name    = "allow-fortiaiops-${random_string.random_name_post.result}"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22", "443"]
  }

  allow {
    protocol = "udp"
    ports    = ["514", "4013"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["allow-fortiaiops"]
}

data "google_compute_address" "ExistingPublicIP" {
  count = var.ExistingPublicIPName != "" ? 1 : 0
  name = var.ExistingPublicIPName
}

# Create FortiAIOps compute instance
resource "google_compute_instance" "default" {
  name           = "fortiaiops-${random_string.random_name_post.result}"
  machine_type   = var.machine
  zone           = var.zone
  can_ip_forward = "true"

  tags = ["allow-fortiaiops"]

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  shielded_instance_config {
    enable_secure_boot = true
  }

  attached_disk {
    source = google_compute_disk.datadisk.name
  }
  network_interface {
    subnetwork = google_compute_subnetwork.public_subnet.name
    access_config {
      nat_ip = var.ExistingPublicIPName != "" ? data.google_compute_address.ExistingPublicIP[0].address : null
    }
  }
  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
  scheduling {
    preemptible       = false
    automatic_restart = false
  }
}

data "google_compute_instance" "default" {
  depends_on = [google_compute_instance.default]
  name       = "fortiaiops-${random_string.random_name_post.result}"
}

