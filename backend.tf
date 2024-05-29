terraform {
  backend "s3" {
    bucket = "lab-terraform-05-03-2024"
    key = "lab-terraform-05-03-2024/website-backend.tfstate"
    region = "us-east-1"
    profile = "terraform-user"
  }
}


