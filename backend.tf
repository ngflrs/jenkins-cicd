terraform {
  backend "s3" {
    bucket         = "your_bucket_name"
    key            = "jenkins/tfstate.tf"
    region         = "us-east-1"
    encrypt        = true
  }
}
