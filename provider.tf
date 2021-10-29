variable "server" {
   type = string
   default = "ru"
}

variable "it_type" {
default = "t2.nano"
}

variable "ami_id" {
default = "ami-02e136e904f3da870" 
}

resource "aws_instance" "myservers" {
   ami = var.ami_id
   instance_type = var.it_type
   tags = {
      Name = "${var.server}-29oct"
      env = "test"
   }
}

output "Public_IP" {
  value = aws_instance.myservers.public_ip 
}

output "Private_IP" {
  value = value = aws_instance.myservers.private_ip 
}
