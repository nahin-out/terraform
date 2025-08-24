terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~>5.0"
    }
  }
}

provider "aws" {
    region = var.region
    profile = "default"
  
}

resource "aws_vpc" "nahin" {
    cidr_block = var.vpc_cidr
    enable_dns_support = true
    enable_dns_hostnames = true

    tags = {
      Name = "DemoVPC-${terraform.workspace}"
    }
}

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.nahin.id
    cidr_block = var.public_subnet_cidr
    map_public_ip_on_launch = true

    tags = {
        Name = "PublicSubnet-${terraform.workspace}"
    }
}

resource "aws_subnet" "private" {
    vpc_id = aws_vpc.nahin.id
    cidr_block = var.private_subnet_cidr

    tags = {
      Name = "PrivateSubnet-${terraform.workspace}"
    }
  
}
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.nahin.id

    tags = {
        Name = "DemoIGW-${terraform.workspace}"
    }  
}

output "vpc" {
    value = aws_vpc.nahin.id
  
}

output "public_subnet" {
    value = aws_subnet.public.id  
}

output "private_subnet" {
    value = aws_subnet.private.id  
}

output "internet_gateway" {
    value = aws_internet_gateway.igw.id  
}