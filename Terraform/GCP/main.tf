terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.43.1"
    }
  }
}

provider "google" {
  project = "github-code-snippets"
  region  = "us-central1"
  zone    = "us-central1-c"
}

# Create google cloud network
resource "google_compute_network" "vpc_network" {
  name                            = "terraform-network"
  auto_create_subnetworks         = true
  delete_default_routes_on_create = false
  mtu                             = 1420
  routing_mode                    = "REGIONAL"
}

# Create a Google cloud compute instance
resource "google_compute_instance" "vm_instance" {
  name                = "terraform-instance"
  machine_type        = "f1-micro"
  zone                = "us-central1-c"
  can_ip_forward      = false
  deletion_protection = false
  enable_display      = false
  boot_disk {
    auto_delete = true
    device_name = "persistent-disk-0"
    mode        = "READ_WRITE"
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = 10
      type  = "pd-standard"
    }
  }
  network_interface {
    queue_count = 0
    network     = google_compute_network.vpc_network.name
    access_config {
      network_tier = "PREMIUM"
    }
  }
  scheduling {
    automatic_restart   = true
    min_node_cpus       = 0
    on_host_maintenance = "MIGRATE"
    preemptible         = false
    provisioning_model  = "STANDARD"
  }
  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = false
    enable_vtpm                 = true
  }
}

# Create google cloud firewall
resource "google_compute_firewall" "ssh" {
  name = "allow-ssh"
  allow {
    ports    = ["22"]
    protocol = "tcp"
  }
  direction     = "INGRESS"
  network       = google_compute_network.vpc_network.id
  priority      = 1000
  # [Shisho]: remove `0.0.0.0/0` from the following line and add appropriate IP ranges
  source_ranges = [ "0.0.0.0/0" ]
  target_tags   = ["ssh"]
}


# Create a google cloud SQL instance
resource "google_sql_database_instance" "main" {
  name                = "main-instance"
  deletion_protection = false
  database_version    = "POSTGRES_14"
  region              = "us-central1"
  settings {
    activation_policy     = "ALWAYS"
    availability_type     = "ZONAL"
    tier                  = "db-f1-micro"
    disk_autoresize       = true
    disk_autoresize_limit = 0
    disk_size             = 10
    disk_type             = "PD_SSD"
    pricing_plan          = "PER_USE"
    backup_configuration {
      binary_log_enabled             = false
      enabled                        = true
      point_in_time_recovery_enabled = true
      start_time                     = "00:00"
      transaction_log_retention_days = 7
      backup_retention_settings {
        retained_backups = 7
        retention_unit   = "COUNT"
      }
    }
    ip_configuration {
      ipv4_enabled = true
      require_ssl  = true
    }
    location_preference {
      zone = "us-central1-c"
    }
  }
}