provider "random" {}

variable "env_name" {
    type = string
}

resource "random_pet" "example" {
    length = 3
    separator = "-"
    prefix = var.env_name
  
}

output "pet_name" {
    value = random_pet.example.id
  
}