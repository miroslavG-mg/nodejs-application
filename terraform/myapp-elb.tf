resource "aws_elb" "myapp-elb" {
  name = "myapp-elb"
  subnets = [aws_subnet.main-public.id]
  security_groups = [aws_security_group.elb-securitygroup.id]
  listener {
    instance_port = var.myapp_port
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "HTTP:${var.myapp_port}/"
    interval = 30
  }

  cross_zone_load_balancing = true
  connection_draining = true
  connection_draining_timeout = 400
  tags = {
    Name = "my-elb"
  }
}

resource "aws_security_group" "elb-securitygroup" {
  vpc_id = aws_vpc.main.id
  name = "elb"
  description = "security group for load balancer"
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "api-elb"
  }
}


output "MyApp-ELB" {
  value = aws_elb.myapp-elb.dns_name
}
