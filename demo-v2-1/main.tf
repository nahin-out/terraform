terraform {
    required_providers {
        random = {
            source = "hashicorp/random"
            version = "3.6.0"
        }
    }
}

provider "random" {}

# Use variables instead of harcoding
resource "random_pet" "my_pet" {
    length  = var.pet_length
    separator = var.pet_separator
}

output "pet_name" {
    value = random_pet.my_pet.id
}