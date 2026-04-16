terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0" # Última versión mayor 
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Redes (VPC con bloque 10.1.0.0/16) [cite: 57]
resource "aws_vpc" "main" {
  cidr_block = "10.1.0.0/16"
  tags = { Name = "002V-duocapp-vpc" } 
}

# Subred /24 [cite: 58]
resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.1.1.0/24"
  tags = { Name = "002V-duocapp-sub" }
}

# Security Group (Solo tráfico SSH entrante) [cite: 59, 60]
resource "aws_security_group" "allow_ssh" {
  name   = "002V-duocapp-sg"
  vpc_id = aws_vpc.main.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
}

# Cómputo: EC2 Ubuntu 24.04 LTS tipo t2.micro [cite: 65]
resource "aws_instance" "web" {
  ami           = "ami-0a2b3c4d5e6f7g8h9" 
  instance_type = "t2.micro"
  tags          = { Name = "002V-duocapp-ec2" }
}
