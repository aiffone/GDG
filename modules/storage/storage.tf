resource "google_storage_bucket" "storage" {
  name                        = "tf-bucket-943027"
  location                    = "US"
  force_destroy               = true
  uniform_bucket_level_access = true
}
