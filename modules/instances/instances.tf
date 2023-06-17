# instance 1
resource "google_compute_instance" "tf-instance-1" {
  name         = "tf-instance-1"
  machine_type = "n1-standard-2"
  zone         = "us-east1-c"
  
  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

  network_interface {
    network = "tf-vpc-596621"
    subnetwork = "subnet-01"
    access_config {
      // Optional access configuration
    }
  }

  metadata_startup_script = <<-EOT
        #!/bin/bash
    EOT

  allow_stopping_for_update = true
}
# instance 2

resource "google_compute_instance" "tf-instance-2" {
  name         = "tf-instance-2"
  machine_type = "n1-standard-2"
  zone         = "us-east1-c"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

  network_interface {
    network = "tf-vpc-596621"
    subnetwork = "subnet-02"
    access_config {
      // Optional access configuration
    }
  }

  metadata_startup_script = <<-EOT
        #!/bin/bash
    EOT

  allow_stopping_for_update = true
}


# instance 3

# resource "google_compute_instance" "tf-instance-365228" {
#   name         = "tf-instance-365228"
#   machine_type = "n1-standard-2"
#   zone         = "us-east1-c"

#   tags = ["foo", "bar"]

#   boot_disk {
#     initialize_params {
#       image = "debian-cloud/debian-11"
#       labels = {
#         my_label = "value"
#       }
#     }
#   }

#   network_interface {
#     network = "default"
#     access_config {
#       // Optional access configuration
#     }
#   }

#   metadata_startup_script = <<-EOT
#         #!/bin/bash
#     EOT

#   allow_stopping_for_update = true
# }

