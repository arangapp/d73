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
