terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket-website3"
    key            = "terraform.tfstate"
    region         = "eu-west-2"
    encrypt        = true
  }

}
