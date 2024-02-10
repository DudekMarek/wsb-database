resource "google_sql_database_instance" "wsb_postgresql" {
  name             = "wsb-postgresql"
  database_version = "POSTGRES_9_6"
  region           = local.region

  settings {
    tier = "db-f1-micro"
  }

  deletion_protection = false
}

resource "google_sql_database" "test" {
  name     = "test"
  instance = google_sql_database_instance.wsb_postgresql.name
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "google_sql_user" "test_user" {
  name     = "test-user"
  instance = google_sql_database_instance.wsb_postgresql.name
  password = random_password.password.result

  lifecycle {
    ignore_changes = [password]
  }
}

output "sql_password" {
  value     = google_sql_user.test_user.password
  sensitive = true
}
