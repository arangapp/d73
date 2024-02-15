resource "aws_instance" "web" {
  for_each = var.instances
  ami           = "ami-a1b2c3d4"
  instance_type = lookup(each.value, "instance_type", "t2.micro")

  tags = {
    Name = each.key
  }
}

data "aws_ami" "example" {
  owner = ["973714476881"]
  most_recent = true
  name_regex = "Centos-8-DevOps-Practice"
}

variable "instances" {

  default = {
    ${component} ={
      name = "${component}"
    }
    ${component} ={
      name = "${component}"
    }
    ${component} ={
      name = "${component}"
    }
  }
}