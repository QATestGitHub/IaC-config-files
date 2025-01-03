resource "aws_instance" "ExampleInstance" {
ami = "ami-0b69ea66ff739e80"
	instance_type = "t2.micro"
	tags {
		Name = "EC2_Instance_Terraform"
	}
logging = true
}
