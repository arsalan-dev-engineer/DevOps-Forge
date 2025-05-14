terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket-website-5"
    key            = "terraform.tfstate"
    region         = "eu-west-2"
    encrypt        = true
  }

}
