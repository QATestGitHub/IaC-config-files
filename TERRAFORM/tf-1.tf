---
resource "aws_iam_role" "ec2_role" {
  name = "ec2_instance_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2_instance_profile"
  role = aws_iam_role.ec2_role.name
}

resource "aws_instance" "ExampleInstance" {
  ami                    = "ami-0b69ea66ff739e80"
  instance_type          = "t2.micro"
  monitoring             = true
  ebs_optimized          = true
  iam_instance_profile   = aws_iam_instance_profile.ec2_instance_profile.name

  metadata_options {
    http_tokens = "required"
    http_endpoint = "enabled"
    instance_metadata_tags = "enabled"
  }

  root_block_device {
    volume_type = "gp2"
    volume_size = 8
    delete_on_termination = true
  }

  tags = {
    Name = "EC2_Instance_Terraform"
  }
}
