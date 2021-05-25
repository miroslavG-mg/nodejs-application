terraform {
  backend "s3" {
    bucket = "myapp-bucket-terraform"
    key = "myapp-bucket-terraform.tfstate"
    region = "us-east-1"
    access_key = "AKIAUS7DVJ6LQLU375GS"
    secret_key = "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"
  }
}
