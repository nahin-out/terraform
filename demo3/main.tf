terraform {
    required_providers {
        random = {
            source = "hashicorp/random"
            version = "3.6.0"
        }
    }
}


provider "random" {}

# Resource 1: Random pet
resource "random_pet" "my_pet" {
    length = 3
    separator = ":"
}

# Resource 2: Random string
resource "random_string" "my_string" {
    length = 15
    special = true
    upper = true
}

# output both values
output "lucky_winner" {
    value = random_pet.my_pet.id
}

output "todays_meal"{
    value = random_string.my_string.id
}