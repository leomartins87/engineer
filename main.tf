terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.55.0"
    }
  }
}

#Use an ssh-key pair

locals {
        ssh_user         = "engineer"
        key_name         = "ssh-key-pair1"
        private_key_path = "/tmp/ssh-key-pair1.pem"
}


#Create a security group to allow port connections

resource "aws_security_group" "nginx" {
        name = "nginx_access"
#VPC 

        ingress {
         from_port = 22
         to_port   = 22
         protocol  = "tcp"
         cidr_blocks = ["0.0.0.0/0"]
        }

        ingress {
         from_port = 80
         to_port   = 80
         protocol  = "tcp"
         cidr_blocks = ["0.0.0.0/0"]
        }

        egress {
         from_port = 0
         to_port   = 0
         protocol  = "-1"
         cidr_blocks = ["0.0.0.0/0"]
        }
}



# Create an EC2 instance

resource "aws_instance" "ubuntu-nginx" {
        ami     = "ami-0735c191cf914754d"
        instance_type = "t2.micro"
        associate_public_ip_address = true
        security_groups  = [aws_security_group.nginx.id]
        key_name = local.key_name
        tags = {
                Name = "nginx-ubuntu-vm"
                Description = "Ubuntu vm with nginx"
        }
}
