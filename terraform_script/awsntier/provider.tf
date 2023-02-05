provider "aws" {
  region = "ap-south-1"

}
resource "aws_vpc" "saivpc" {
  cidr_block = var.vpc_details.vpc_range
  tags = {
    Name = var.vpc_details.name
  }

}
resource "aws_subnet" "saisubnet" {
  vpc_id     = aws_vpc.saivpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    "name" = "public"
  }
}
resource "aws_subnet" "saisubnet1" {
    vpc_id     = aws_vpc.saivpc.id
  cidr_block = "10.0.2.0/24"
  tags = {
    "name" = "private"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.saivpc.id

  tags = {
    Name = "igw"
  }
}

resource "aws_eip" "ib" {
  vpc = true
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.ib.id
  subnet_id     = aws_subnet.saisubnet1.id

  tags = {
    Name = "NAT"
  }
}

resource "aws_route_table" "rt1" {
  vpc_id = aws_vpc.saivpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "public"
  }
}

resource "aws_route_table" "rt2" {
  vpc_id = aws_vpc.saivpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw.id
  }
  tags = {
    Name = "private"
  }
}


resource "aws_security_group" "sg" {
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.saivpc.id

  ingress {

    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.saivpc.cidr_block]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = "sg1"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.saisubnet.id
  route_table_id = aws_route_table.rt1.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.saisubnet1.id
  route_table_id = aws_route_table.rt2.id
}


resource "aws_instance" "sai" {
  ami           = "ami-069d9fecd19e7ed40"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.saisubnet.id
  key_name      = "krishna"
  tags = {
    Name = "appserver"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd -y",
      "sudo yum update",
      "sudo yum update",
      "curl -fsSL https://get.docker.com -o get-docker.sh",
      "sh get-docker.sh"

    ]
    connection {
      type        = "ssh"
      user        = "satya"
      host        = element(aws_instance.sai.*.public_ip, 0)
      private_key = file("~/.ssh/id_rsa")

    }
  }
}

resource "aws_instance" "sai1" {
  ami           = "ami-069d9fecd19e7ed40"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.saisubnet1.id
key_name        = "krishna"
  tags = {
    Name = "web server"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo yum update",
      "curl -fsSL https://get.docker.com -o get-docker.sh",
      "sh get-docker.sh"
    ]
connection {
      type        = "ssh"
      user        = "satya"
      host        = element(aws_instance.sai.*.public_ip, 0)
      private_key = file("~/.ssh/id_rsa")

    }
    
  }
}

