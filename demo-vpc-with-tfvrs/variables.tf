variable "env" {
    description = "Dev section build"
    type = string
}

variable "region" {
    description = "Aws region selection"
    type = string
}

variable "vpc_cidr" {
    description = "vpc cidr block selection"
    type = string
}

variable "pub_subnet_cidr" {
    description = "adding public subnet cidr block"  
    type = string
}

variable "pvt_subnet_cidr" {
    description = "adding private subnet cidr block"
    type = string
}

variable "pub_avl_zone" {
    description = "Aws Avaailablility zone for public"
    type = string
}

variable "pvt_avl_zone" {
    description = "Aws Avaialbilitry zone for private"
    type = string
}