resource "aws_launch_configuration" "myapp-launchconfig" {
  name_prefix          = "myapp-launchconfig-"
  image_id             = var.ami_id
  instance_type        = "t2.micro"
  security_groups      = [aws_security_group.myapp-instance.id]

  user_data = file("start-application.sh")

  connection {
    user = var.instance_username
    private_key = file(var.path_private_key)
  }

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_autoscaling_group" "myapp-autoscaling" {
  name = "${aws_launch_configuration.myapp-launchconfig.name}-asg"

  vpc_zone_identifier  = [aws_subnet.main-public.id]
  launch_configuration = aws_launch_configuration.myapp-launchconfig.name
  min_size             = 1
  max_size             = 1
  health_check_grace_period = 300
  health_check_type = "ELB"
  load_balancers = [aws_elb.myapp-elb.name]

  force_delete = true

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key = "Name"
    value = "myapp ec2 instance"
    propagate_at_launch = true
  }
}


