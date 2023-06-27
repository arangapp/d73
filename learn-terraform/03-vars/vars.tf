variable "sample"{
  default = 1000
}

variable "sample1"{
  default = "Ayanshu Adwaith"
}
output "sample" {
  value = var.sample
}

output "sample1" {
  value = var.sample1
}

output "sample-ext" {
  value = "Value of sample & sample1 - ${var.sample} - ${var.sample1}"
}

# Variable data type
# string
# number
# boolean

#Variable types in Ansible

# plain key ,list ,Map/dict

#In terraform
#1.Plain
#2.List
#3.Map

# plain
variable "course" {
  default = "DevOps training"
}

variable "courses" {
  default = [
   "aws"
   "terraform"
    "Ansible"
  ]
}

variable "course_details" {
  aws = {
    "ec2"
    "s3"
  }
  ansible = {
    "vars"
    "functions"
    "modules"
  }
}

output "course" {
  value = "var.course"
}
output "courses" {
  value = "var.courses"
}

output "course_details" {
  value = "var.course_details"
}
