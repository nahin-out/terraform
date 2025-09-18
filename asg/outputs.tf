output "alb_dns_name" {
  value = aws_lb.my-alb.dns_name
}

output "vpc_id" {
  value = aws_vpc.test.id
}