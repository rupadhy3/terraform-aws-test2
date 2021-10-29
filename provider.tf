provider "aws" {
   region = "us-east-1"
}

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

variable "environment" {}

variable "pubkey" {
   type = string
   default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCd/IZkaLQdSEHjoEMvvE7b65CV+FsJc9gFcublKSyzWgFM3aJIkCEo58v7KCL1c2GyU3k4IRppl4ZGJy28oOoQQol4ai9r39XUjGI1BGQclB9SHMWa9g33L9v2vKGBd4h/8fAFbw2pJgODXuo5pHmiAwVJtomKgc4C2TVdKsaSaysosztRUd/Y5bsSnvYE1gmDdSL4/vSj98r+5oeJ8btPQQdlwFdgf7Zy561hY2Ho7gDdioCIl1ZJeGgijTcQrp/BVK+tGT8HPK6PKMNG7dvGxBkQmPD5JvSn8UiDzxRDUOHp0Zq8RSrWuzs/6oMQjc1oCNFlZ/h9y/EbYm4pOnsd root@ip-172-31-30-163.ec2.internal"
}

resource "aws_instance" "myservers" {
   ami = ${ var.environment == "prod" ? var.ami_id_redhat : var.ami_id_ubuntu }
   instance_type = ${ var.environment == "prod" ? var.it_redhat : var.it_ubuntu }
   key_name = aws_key_pair.mykeypair.key_name


   tags = {
      Name = ${var.server}-28oct
      env = "test"
   }
}

resource "aws_key_pair" "mykeypair" {
  key_name   = "rukey-27oct"
  public_key = var.pubkey
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

