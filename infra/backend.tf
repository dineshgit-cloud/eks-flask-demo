terraform {
  backend "s3" {
    bucket = "terraform-dinesh-poc-commercetools"
    key    = "infra/terraform.tfstate"
    region = "eu-central-1"
    encrypt = true
  }
}
