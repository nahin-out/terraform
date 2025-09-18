resource "aws_lb" "app_load_balancer" {
    name               = "app-load-balancer"
    internal           = false
    load_balancer_type = "application"
    security_groups    = [aws_security_group.alb-sg.id]
    subnets            = aws_subnet.public[*].id

    tags = {
        Name = "app-load-balancer"
    }
  
}

#Target Group
resource "aws_lb_target_group" "app_tg" {
    name     = "app-tg"
    port     = 80
    protocol = "HTTP"
    vpc_id   = aws_vpc.test.id

    health_check {
        path                = "/"
        protocol            = "HTTP"
        matcher             = "200-399"
        interval            = 30
        timeout             = 5
        healthy_threshold   = 2
        unhealthy_threshold = 2
    }
    tags = {
        Name = "app-tg"
    }
}

#Listener
resource "aws_lb_listener" "app_listener" {
    load_balancer_arn = aws_lb.app_load_balancer.arn
    port              = "80"
    protocol          = "HTTP"

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.app_tg.arn
    }
}