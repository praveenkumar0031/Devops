resource "aws_s3_bucket" "my-s3-bucket" {
  bucket="tera-pk-0031"
  tags = {
    Name="tera-pk-0031"
    team=var.tag_team
    config_platform=var.tag_platform
  }
}