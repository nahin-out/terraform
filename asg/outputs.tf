output "alb_dns_name" {
  value = aws_lb.app_load_balancer.dns_name
}

output "vpc_id" {
  value = aws_vpc.test.id
}