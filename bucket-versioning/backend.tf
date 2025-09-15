terraform {
  backend "s3" {
    bucket = "balti-x"
    key = "dev/terraform.tfstate"
    region = "ap-northeast-1"
    dynamodb_table = "terraform-locks"
    encrypt = true
  }
}