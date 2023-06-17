provider "google" {
  project     = "qwiklabs-gcp-02-9b4a505272da"
  region      = "us-east1"
}

provider "google" {
  project     = "qwiklabs-gcp-03-89dd7a7cec72"
  region      = "us-east1"
  zone        = "us-east1-d"
}

module "intances" {
    source = "./modules/instances"
}

module "storage" {
    source = "./modules/storage"
}

terraform {
  backend "gcs" {
    bucket  = "tf-bucket-943027"
    prefix  = "terraform/state"
  }
}


module "vpc" {
    source  = "terraform-google-modules/network/google"
    version = "~> 6.0.0"

    project_id   = "qwiklabs-gcp-03-89dd7a7cec72"
    network_name = "tf-vpc-596621"
    routing_mode = "GLOBAL"

    subnets = [
        {
            subnet_name           = "subnet-01"
            subnet_ip             = "10.10.10.0/24"
            subnet_region         = "us-east1"
        },
        {
            subnet_name           = "subnet-02"
            subnet_ip             = "10.10.20.0/24"
            subnet_region         = "us-east1"
            subnet_private_access = "true"
            subnet_flow_logs      = "true"
            description           = "This subnet has a description"
        },
        
    ]

}

# firewall

resource "google_compute_firewall" "default" {
  name    = "tf-firewall"
  network = google_compute_network.tf-vpc-596621

  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  source_ranges = ["0.0.0.0/0"]
  source_tags = ["web"]
}

resource "google_compute_network" "default" {
  name = "tf-vpc-596621"
}
