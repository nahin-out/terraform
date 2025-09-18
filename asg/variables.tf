variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "ap-northeast-1"
  
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/24"
}

variable "public_subnet" {
  description = "The CIDR block for the public subnet"
  type        = list(string)
  default     = ["10.0.0.0/26", "10.0.0.65/26"] 
}

variable "private_subnet" {
  description = "The CIDR block for the private subnet"
  type        = list(string)
  default     = ["10.0.0.129/26", "10.0.0.193/26"]
}
variable "instance_type" {
  description = "The type of EC2 instance to use"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0a71a0b9c988d5e5e"
}