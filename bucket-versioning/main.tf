provider "aws" {
    region = "ap-northeast-1"
}

resource "aws_instance" "test-ec2" {
    ami = "ami-0228232d282f16465"  # Amazon Linux 2 AMI (HVM), SSD Volume Type
    instance_type = "t2.micro"

    tags = {
        Name = "balti-xx-instance"
        Environment = "dev"
    }
  
}


resource "aws_s3_bucket" "balti-xx" {
    bucket = "balti-xx"
    force_destroy = true

    tags = {
        Name = "balti-xx"
        Environment = "dev"
    }  
}

