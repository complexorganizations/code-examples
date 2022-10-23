terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["assets/.env/.aws/credentials"]
}

# Create the internet gateway
resource "aws_internet_gateway" "main_internet_gateway" {
  vpc_id = aws_vpc.main_vpc.id
}

# Create a route table
resource "aws_route_table" "main_route_table" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block        = "0.0.0.0/0"
    gateway_id        = aws_internet_gateway.main_internet_gateway.id
    ipv6_ipam_pool_id = aws_vpc_ipv6_cidr_block.main_ipv6_cidr_block.ipv6_pool
  }
  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.main_internet_gateway.id
  }
}

resource "main_ipv6_cidr_block" "main_ipv6_cidr_block" {
  vpc_id                          = aws_vpc.main_vpc.id
  amazon_provided_ipv6_cidr_block = true
}

# route table association
resource "aws_route_table_association" "main_route_table_association" {
  subnet_id      = aws_subnet.main_subnet.id
  route_table_id = aws_route_table.main_route_table.id
}

# Create a VPC
resource "aws_vpc" "main_vpc" {
  cidr_block           = "10.0.0.0/16"
  ipv6_cidr_block      = "2001:db8:1234:1a00::/56"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

# Create a subnet
resource "aws_subnet" "main_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  ipv6_cidr_block   = "2001:db8:1234:1a00::/64"
}

# Create a security group
resource "aws_security_group" "main_security_group" {
  name        = "main_security_group"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = aws_vpc.main_vpc.id
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Deploy an EC2 instance
resource "aws_instance" "main_instance" {
  ami                         = "ami-08c40ec9ead489470"
  instance_type               = "t1.micro"
  subnet_id                   = aws_subnet.main_subnet.id
  vpc_security_group_ids      = [aws_security_group.main_security_group.id]
  ipv6_address_count          = 1
  associate_public_ip_address = true
  depends_on                  = [aws_internet_gateway.main_internet_gateway]
  credit_specification {
    cpu_credits = "unlimited"
  }
}
