variable "pet_length" {
    description = "How many words in the pet name"
    type        = number
    default     = 2
}

variable "pet_separator" {
    description = "Separator for the pet name"
    type = string
    default = "-"
}