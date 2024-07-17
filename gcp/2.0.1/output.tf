# Output
output "FortiAIOps-IP" {
  value = google_compute_instance.default.network_interface.0.access_config.0.nat_ip
}
output "FortiAIOps-InstanceName" {
  value = google_compute_instance.default.name
}
output "FortiAIOps-Username" {
  value = "admin"
}