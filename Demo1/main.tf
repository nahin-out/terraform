
terraform {
  required_providers {
   random = {
    source = "hashicorp/random"
    version = "3.6.0"
  }
 }
}

provider "random" {}

resource "random_pet" "example" {
  length = 2
} 
