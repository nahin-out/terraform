resource "aws_vpc" "test" {
    cidr_block = var.vpc_cidr
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
        Name = "test-vpc"
    }
}
data "aws_availability_zones" "available" {
    state = "available"
}

resource "aws_subnet" "public" {
    count = length(var.public_subnet)
    vpc_id = aws_vpc.test.id
    cidr_block = var.public_subnet[count.index]
    map_public_ip_on_launch = true
    availability_zone = element(data.aws_availability_zones.available.names, count.index)
    tags = {
        Name = "public-subnet-${count.index + 1}"
    }
}

resource "aws_subnet" "private" {
    count = length(var.private_subnet)
    vpc_id = aws_vpc.test.id
    cidr_block = var.private_subnet[count.index]
    map_public_ip_on_launch = false
    availability_zone = element(data.aws_availability_zones.available.names, count.index)
    tags = {
        Name = "private-subnet-${count.index + 1}"
    }
}