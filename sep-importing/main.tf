resource "aws_vpc" "test" {
    cidr_block = "10.0.0.0/24"

    tags = {
      Type = "custom-vpc"
      Environment = "dev" 
      Name        = "test-dev"
      } 
}

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.test.id
    cidr_block = "10.0.0.0/26"
    map_public_ip_on_launch = true

    tags = {
      Name = "PublicSubnet-dev"
      Environment = "dev"
      Type = "public"
    }
}


#terraform init
#vpc-import > terraform import aws_vpc.test vpc-08530836eb6e1c66a (vpc id will be collected manually)
#terraform plan
#subnet-import > terraform import aws_subnet.public subnet-0693a36495012742a (will be collected manually)
#terraform plan