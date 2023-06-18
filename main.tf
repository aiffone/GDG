provider "google" {
  project     = "qwiklabs-gcp-02-b42bcbffd311"
  region      = "us-east1"
  zone        = "us-east1-c"
}

module "intances" {
    source = "./modules/instances"
}

module "storage" {
    source = "./modules/storage"
}

terraform {
  backend "gcs" {
    bucket  = "tf-bucket-842413"
    prefix  = "terraform/state"
  }
}


module "vpc" {
    source  = "terraform-google-modules/network/google"
    version = "~> 6.0.0"

    project_id   = "qwiklabs-gcp-02-b42bcbffd311"
    network_name = "tf-vpc-455759"
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

# # firewall

resource "google_compute_firewall" "tf-firewall" {
  name          = "tf-firewall"
  network       = "projects/qwiklabs-gcp-02-b42bcbffd311/global/networks/tf-vpc-455759"

  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  source_tags   = ["web"]
}






