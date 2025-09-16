provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_instance" "web" {
  ami           = "ami-0a71a0b9c988d5e5e" # Amazon Linux 2 AMI
  instance_type = "t3.micro"

    user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install -y apache2
              sudo systemctl enable apache2
              sudo systemctl start apache2
              echo "<h1>Hello from Terraform</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "TestWebInstance"
  }
  
}