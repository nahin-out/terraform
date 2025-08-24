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
}

resource "aws_vpc" "testing" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = "testing-${terraform.workspace}"
    }
}

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.testing.id
    cidr_block = var.public_subnet_cidr
    availability_zone = var.public_availability_zone
    map_public_ip_on_launch = true
    tags = {
        Name = "PublicSubnet-${terraform.workspace}"
    } 
}

resource "aws_subnet" "private" {
    vpc_id = aws_vpc.testing.id
    cidr_block = var.private_subnet_cidr
    availability_zone = var.private_availability_zone
    tags = {
      Name = "PrivateSubent-${terraform.workspace}"
    }
}

resource "aws_internet_gateway" "igway" {
    vpc_id = aws_vpc.testing.id
    tags = {
      Name = "IntGateway-${terraform.workspace}"
    }
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.testing.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igway.id
    }

    tags = {
      Name = "PublicRouteTable-${terraform.workspace}"
    }
}

resource "aws_route_table_association" "public_association_link" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.public.id  
}

output "vpc_id_name" {
    value = aws_vpc.testing.id
}
output "public_subnet_id_name" {
    value = aws_subnet.public.id
}

output "private_subnet_id_name" {
    value = aws_subnet.private.id
}

output "aws_internet_gateway_result" {
    value = aws_internet_gateway.igway.id
}

output "aws_route_table" {
    value = aws_route_table.public.id
}