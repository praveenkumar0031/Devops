resource "aws_instance" "test-ec2"{
    ami=var.ami_name
    instance_type = "t3.micro"
    subnet_id = aws_subnet.tf-public_ip.id
    associate_public_ip_address = true
    key_name = "test"
    vpc_security_group_ids = [ aws_security_group.tf_sg.id ]
    tags = {
    Name     = "test ec2"
    Team     = var.tag_team
    Platform = var.tag_platform
  }
}

output "test-ec2_public_ip" {
  value = aws_instance.test-ec2.public_ip
}
resource "aws_instance" "db-ec2"{
    ami=var.ami_name
    instance_type = "t3.micro"
    subnet_id = aws_subnet.tf-private_ip.id
    
    key_name = "test"
    vpc_security_group_ids = [ aws_security_group.tf_sg.id ]
    tags = {
    Name     = "db-ec2"
    Team     = var.tag_team
    Platform = var.tag_platform
  }
}
  