terraform {
  required_providers {
    random = {
        source = "hashicorp/random"
        version = "3.6.0"
    }
  }
}

provider "random" {}

resource "random_string" "nahin" {
  length = 12
  special = true
  upper = true
}

output "nahin_string" {
    value = "${terraform.workspace}-${random_string.nahin.result}"
}