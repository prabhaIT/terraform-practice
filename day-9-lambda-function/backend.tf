terraform {
  backend "s3" {
    bucket = "sreenivasulu.co.in"
    key = "day-9/lambda-function"
    use_lockfile = true
    region = "ap-south-1"
    
  }
}