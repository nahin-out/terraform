resource "aws_security_group" "alb-sg" {
    name        = "alb-sg"
    description = "Security group for ALB"
    vpc_id      = aws_vpc.test.id

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]  
}
    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    } 
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "alb-sg"
    }
}   
resource "aws_security_group" "ec2-sg" {
    name        = "asg-sg"
    description = "Security group for EC2 instances"
    vpc_id      = aws_vpc.test.id

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        security_groups = [aws_security_group.alb-sg.id] 
}
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        security_groups = ["aws_security_group.bastion-sg.id"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "asg-sg"
    }
}

resource "aws_security_group" "bastion-sg" {
    name        = "bastion-sg"
    description = "Security group for Bastion host"
    vpc_id      = aws_vpc.test.id

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["YOUR_PUBLIC_IP/32"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "bastion-sg"
    }
}

resource "aws_security_group" "db-sg" {
    name        = "db-sg"
    description = "Security group for PostgreSQL"
    vpc_id      = aws_vpc.test.id

    ingress {
        from_port   = 5432
        to_port     = 5432
        protocol    = "tcp"
        security_groups = [aws_security_group.ec2-sg.id] 
        }

    ingress {
        from_port   = 5432
        to_port     = 5432
        protocol    = "tcp"
        security_groups = [aws_security_group.bastion-sg.id] 
        }
        
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "db-sg"
    }
}  
