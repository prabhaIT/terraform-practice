terraform {
  backend "s3" {
    bucket = "prabha-terraform-s3-bucket"
    key ="day-4/terraform.tfstate"
    region ="ap-south-1"
    
  }
}