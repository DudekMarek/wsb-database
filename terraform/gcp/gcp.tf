provider "google" {
  credentials = local.credentials
  project     = local.project
  region      = local.region
}

provider "random" {}
