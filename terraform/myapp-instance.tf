provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "myapp-instance" {
  vpc_id = aws_vpc.main.id
  name = "mysecuritygroup"
  
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port = var.myapp_port
    to_port = var.myapp_port
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "myapp-ec2-instance"
  }
}
