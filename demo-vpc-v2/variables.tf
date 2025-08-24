variable "region" {
    description = "Aws region "
    type = string
    default = "ap-northeast-1"  
}

variable "vpc_cidr" {
    description = "vpc cidr block listed"
    default = "10.0.0.0/24"  
}

variable "public_subnet_cidr" {
    description = "adding public subnet for vpc_cidr"
    default = "10.0.0.0/26"
}

variable "private_subnet_cidr" {
    description = "adding private subnet for vpc_cidr"
    default = "10.0.0.64/26"
}

variable "public_availability_zone" {
    description = "AZ public selection"
    default = "ap-northeast-1a"  
}

variable "private_availability_zone" {
    description = "AZ private selection"
    default = "ap-northeast-1c"
}