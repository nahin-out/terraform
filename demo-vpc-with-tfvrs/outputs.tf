output "vpc" {
    value = aws_vpc.test.id
}

output "public_subnet" {
    value = aws_subnet.public.id
}

output "private_subnet" {
    value = aws_subnet.private.id
}

output "internetGateway" {
    value = aws_internet_gateway.IntGaWay.id
}

output "route_table" {
    value = aws_route_table.publicRoutetable.id
}