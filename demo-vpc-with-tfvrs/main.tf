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

resource "aws_vpc" "test" {
    cidr_block = var.vpc_cidr
    tags = {
      Name = "test-${terraform.workspace}"
    } 
}

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.test.id
    cidr_block = var.pub_subnet_cidr
    availability_zone = var.pub_avl_zone
    map_public_ip_on_launch = true
    tags = {
      Name = "PublicSubnet-${terraform.workspace}"
    }
}

resource "aws_subnet" "private" {
    vpc_id = aws_vpc.test.id
    cidr_block = var.pvt_subnet_cidr
    availability_zone = var.pvt_avl_zone
    tags = {
      Name = "PrivateSubnet-${terraform.workspace}"
    }
}

resource "aws_internet_gateway" "IntGaWay" {
    vpc_id = aws_vpc.test.id
    tags = {
      Name = "IntGateway-${terraform.workspace}"
    }  
}

resource "aws_route_table" "publicRoutetable" {
    vpc_id = aws_vpc.test.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.IntGaWay.id
    }

    tags = {
      Name = "PublicIntGateway-${terraform.workspace}"
    }  
}

resource "aws_route_table_association" "publicRouteTableAssociation" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.publicRoutetable.id
}

output "vpc" {
    value = aws_vpc.test.id
}

output "public_subnet" {
    value = aws_subnet.public.id
}

output "private_subnet" {
    value = aws_subnet.private.id
}

output "internetGateway" {
    value = aws_internet_gateway.IntGaWay.id
}

output "route_table" {
    value = aws_route_table.publicRoutetable.id
}