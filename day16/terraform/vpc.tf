resource "aws_vpc" "tf-vpc" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "tf-vpc"
    team=var.tag_team
    Platform=var.tag_platform
  }
}
#subnet pub
resource "aws_subnet" "tf-public_ip" {
  vpc_id     = aws_vpc.tf-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "tf_public_subnet"
    team= var.tag_team
    Platform=var.tag_platform
  }
}
#subnet private
resource "aws_subnet" "tf-private_ip" {
  vpc_id     = aws_vpc.tf-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "tf_private_subnet"
    team= var.tag_team
    Platform=var.tag_platform
  }
}
#IGW
resource "aws_internet_gateway" "tf-gw" {
  vpc_id = aws_vpc.tf-vpc.id

  tags = {
    Name = "main"
    team=var.tag_team
    Platform=var.tag_platform
  }
}
#route table
resource "aws_route_table" "tf-rt" {
  vpc_id = aws_vpc.tf-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf-gw.id
  }

  

  tags = {
    Name = "example"
    team=var.tag_team
    Platform=var.tag_platform
  }
}
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.tf-public_ip.id
  route_table_id = aws_route_table.tf-rt.id
}
#SG
resource "aws_security_group" "tf_sg" {
  name        = "tf_sg"
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id      = aws_vpc.tf-vpc.id
  
  tags = {
    Name     = "tf_sg"
    team     = var.tag_team
    Platform = var.tag_platform
  }
}
resource "aws_vpc_security_group_ingress_rule" "inbound_ssh" {
  security_group_id = aws_security_group.tf_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}
resource "aws_vpc_security_group_ingress_rule" "inbound_http" {
  security_group_id = aws_security_group.tf_sg.id   
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.tf_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" 
}
