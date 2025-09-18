resource "aws_launch_template" "app_launch_template" {
    name_prefix   = "app-launch-template"
    image_id      = data.aws_ami.ubuntu.id
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.ec2-sg.id]

    user_data = base64encode(<<-EOF
                #!/bin/bash
                sudo apt-get update -y
                sudo apt-get install -y nginx
                sudo systemctl start nginx
                sudo systemctl enable nginx
                echo "<h1>Welcome to the Auto Scaling Group!</h1>" > /var/www/html/index.html
            EOF
        )
    lifecycle {
        create_before_destroy = true
    }

    tags = {
        Name = "app-launch-template"
    }
}

resource "aws_autoscaling_group" "app_asg" {
    desired_capacity     = 2
    max_size             = 3
    min_size             = 1
    vpc_zone_identifier  = aws_subnet.private[*].id
    health_check_type   = "EC2"
    
    launch_template {
        id      = aws_launch_template.app_launch_template.id
        version = "$Latest"
    }
    target_group_arns = [aws_lb_target_group.app_tg.arn]

    tag {
        key                 = "Name"
        value               = "app-asg-instance"
        propagate_at_launch = true
    }
}