variable "vpc_cidr" {
    description = "CIDR block for the vpc"
    type = string
    default = "10.0.0.0/24"
}

variable "public_subnet_cidr" {
    description = "CIDR for public subnet"
    type = string
    default = "10.0.0.0/26"  
}

variable "private_subnet_cidr" {
    description = "CIDR for private subnet"
    type = string
    default = "10.0.0.64/26"
}

variable "region" {
    description = "AWS region"
    default = "ap-northeast-1"
}