provider "aws" {
    region = "ap-northeast-1"
}

#for fetching all vpcs from this region. 
#aws ec2 describe-vpcs --region ap-northeast-1 --query "Vpcs[*].VpcId" --output table

data "aws_vpc" "test_vpc" {
    id = "vpc-019df928885ad18c7"
}

data "aws_subnets" "dev_subnets" {
    filter {
        name = "vpc-id"
        values = [data.aws_vpc.test_vpc.id]
    }
}

data "aws_route_tables" "dev_route_tables" {
    filter {
      name = "vpc-id"
      values = [data.aws_vpc.test_vpc.id]
    }
}

data "aws_internet_gateway" "dev_internet_gateway" {
    filter {
      name = "attachment.vpc-id" #attachmet has to be added
      values = [data.aws_vpc.test_vpc.id]
    }  
}


#adding an extra subnet here
resource "aws_subnet" "extra_subnet" {
    vpc_id = data.aws_vpc.test_vpc.id
    cidr_block = "10.0.0.128/26"
    availability_zone = "ap-northeast-1c"
    map_public_ip_on_launch = false
   
    tags = {
      Name = "dev-extra-${terraform.workspace}"
      Environment = terraform.workspace
      Type = "private"
    }
}

#public vs private subnet selection

# Fetch public subnet (Type = public)
data "aws_subnet" "public_subnet" {
  filter {
      name = "vpc-id"
      values = [data.aws_vpc.test_vpc.id]
    }

  filter {
    name   = "tag:Type"
    values = ["public"]
  }

  filter {
    name   = "tag:Environment"
    values = [terraform.workspace]
  }
}

# Fetch private subnet (Type = private)
data "aws_subnets" "private_subnet" {
  filter {
    name = "vpc-id"
    values = [data.aws_vpc.test_vpc.id]
  }

  filter {
    name   = "tag:Type"
    values = ["private"]
  }

  filter {
    name   = "tag:Environment"
    values = [terraform.workspace]
  }
}



#resource
#security_group

resource "aws_security_group" "dev_ec2_sg" {
    name = "dev_ec2_sg"
    description = "security group with Allowing ssh and HTTP"
    vpc_id = data.aws_vpc.test_vpc.id

    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

#ectwo

resource "aws_instance" "dev_ec2" {
    ami = "ami-0a71a0b9c988d5e5e"
    instance_type = "t3.micro"
    subnet_id = try(data.aws_subnets.private_subnet.ids[0], data.aws_subnets.dev_subnets.ids[0])
    
    vpc_security_group_ids = [aws_security_group.dev_ec2_sg.id]

    tags = {
      Name = "ec2-${terraform.workspace}"
    }
}

#output

output "test_vpc" {
    value = data.aws_vpc.test_vpc.id
}

output "test_vpc_cidr" {
    value = data.aws_vpc.test_vpc.cidr_block
}

output "dev_subnets" {
    value = data.aws_subnets.dev_subnets.ids
}

output "dev_route_tables" {
    value = data.aws_route_tables.dev_route_tables.id  
}

output "dev_internet_gateway" {
    value = data.aws_internet_gateway.dev_internet_gateway.id
}

output "dev_ec2_public_ip" {
    value = aws_instance.dev_ec2.public_ip
}