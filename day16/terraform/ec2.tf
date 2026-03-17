resource "aws_instance" "test-ec2"{
    ami=var.ami_name
    instance_type = "t3.micro"
    associate_public_ip_address = true
    key_name = "test"
    vpc_security_group_ids = [ var.sg_id ]
    tags = {
    Name     = "test ec2"
    Team     = var.tag_team
    Platform = var.tag_platform
  }
}