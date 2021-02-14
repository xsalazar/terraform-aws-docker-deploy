//resource "aws_vpc" instance {
//  cidr_block = "10.0.0.0/16"
//  tags       = local.default_tags
//}
//
//resource "aws_internet_gateway" instance {
//  vpc_id = aws_vpc.instance.id
//  tags   = local.default_tags
//}
//
//resource "aws_route_table" public {
//  vpc_id = aws_vpc.instance.id
//  tags   = local.default_tags
//
//  route {
//    cidr_block = "0.0.0.0/0"
//    gateway_id = aws_internet_gateway.instance.id
//  }
//}
//
//resource "aws_route_table" private {
//  vpc_id = aws_vpc.instance.id
//  tags   = local.default_tags
//
//  route {
//    cidr_block     = "0.0.0.0/0"
//    nat_gateway_id = aws_nat_gateway.instance.id
//  }
//}
//
//resource "aws_route_table_association" public {
//  route_table_id = aws_route_table.public.id
//  subnet_id      = aws_subnet.public.id
//}
//
//resource "aws_route_table_association" private {
//  route_table_id = aws_route_table.private.id
//  subnet_id      = aws_subnet.private.id
//}
//
//resource "aws_subnet" public {
//  vpc_id     = aws_vpc.instance.id
//  cidr_block = "10.0.0.0/17"
//  tags       = local.default_tags
//}
//
//resource "aws_subnet" private {
//  vpc_id     = aws_vpc.instance.id
//  cidr_block = "10.0.128.0/17"
//  tags       = local.default_tags
//}
//
//resource "aws_nat_gateway" instance {
//  allocation_id = aws_eip.instance.id
//  subnet_id     = aws_subnet.public.id
//  tags          = local.default_tags
//}
//
//resource "aws_eip" instance {
//  vpc  = true
//  tags = local.default_tags
//}
//
//resource "aws_security_group" instance {
//  vpc_id = aws_vpc.instance.id
//  tags   = local.default_tags
//
//  egress {
//    from_port   = 0
//    protocol    = "-1"
//    to_port     = 0
//    cidr_blocks = ["0.0.0.0/0"]
//  }
//
//  ingress {
//    from_port   = 0
//    protocol    = "-1"
//    to_port     = 0
//    cidr_blocks = ["0.0.0.0/0"]
//  }
//}