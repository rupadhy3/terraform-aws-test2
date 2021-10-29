variable "server" {
   type = string
   default = "ru"
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
  value = aws_instance.myservers.public_ip 
}

output "Private_IP" {
  value = value = aws_instance.myservers.private_ip 
}

