terraform {
  backend "s3" {
    bucket = "myapp-bucket-terraform"
    key = "myapp-bucket-terraform.tfstate"
    region = "us-east-1"
    access_key = ""
    secret_key = ""
  }
}
