terraform {
 required_providers {
    random = {
        source = "hashicorp/random"
        version = "3.6.0"
    }
  }
}

provider "random" {}

resource "random_integer" "example" {
    min = 1
    max = 100
}