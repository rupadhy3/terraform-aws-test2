variable "server" {
   type = string
   default = "ru"
}

variable "it_redhat" {
   type = string
   default = "t2.micro"
}

variable "it_ubuntu" {
   type = string
   default = "t2.nanu"
}

variable "ami_id_redhat" {
   type = string
   default = "ami-0fde50fcbcd46f2f7"
}

variable "ami_id_ubuntu" {
   type = string
   default = "ami-0fde50fcbcd46f2f7"
}

variable "environment" { 
   type = string
   default = "prod" 
}

variable "it_type" {}
variable "ami_id" {}

resource "aws_instance" "myservers" {
   ami = var.ami_id
   instance_type = var.it_type


   tags = {
      Name = "${var.server}-28oct"
      env = "test"
   }
}


output "Public_IP" {
  value = {
    for instance in aws_instance.myservers:
      instance.id => instance.public_ip
  }
}

output "Private_IP" {
  value = {
    for instance in aws_instance.myservers:
      instance.id => instance.private_ip
  }
}

