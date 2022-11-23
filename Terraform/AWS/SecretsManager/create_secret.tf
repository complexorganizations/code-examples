resource "aws_secretsmanager_secret" "example" {
  name                    = "example"
  description             = "This is an example secret"
  recovery_window_in_days = 0
  rotation_rules {
    automatically_after_days = 7
  }
  replica {
    region = "us-east-2"
  }
}