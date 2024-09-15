terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
region = "eu-north-1"
access_key = var.secret_key
secret_key = var.secret_key
}



resource "aws_instance" "My-First-web" {
  ami           = "ami-04cdc91e49cb06165"

  instance_type = var.instance_type

  tags = {
    Name = "HelloWorldMy-First-Ec2"
  }
}


# create a vpc
resource "aws_vpc" "MyLab-vpc"{
    cidr_block = "172.20.0.0/16"

    tags = {
      Name = "MyLab-vpc"
    }
}

resource "aws_subnet" "my-subnet" {
    vpc_id = "${aws_vpc.MyLab-vpc.id}"
    cidr_block = "172.20.10.0/24"

    tags = {
      Name = "my-subnet"
    }
  
}

# create Internet Gateway
 resource "aws_internet_gateway" "MyLab-IntGw" {
   vpc_id = "${aws_vpc.MyLab-vpc.id}"

   tags = {
     Name = "MyLab-InternetGw"
   }
 }

# create security group
resource "aws_security_group" "MyLab_sec_group" {
  name = "MyLab security Group"
  description = "To Allow in and out"
  vpc_id = "${aws_vpc.MyLab-vpc.id}"

  ingress = {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress = {
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  
  
tags = {
  name = "allow traffic"
}
}
