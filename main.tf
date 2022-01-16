
resource "aws_key_pair" "key" {
  key_name   = var.key_name
  public_key = file(var.public_key)
}

resource "aws_launch_configuration" "web" {
  name_prefix                 = "web-"
  image_id                    = "ami-030b8d2037063bab3"
  instance_type               = "t3.micro"
  key_name                    = var.key_name
  security_groups             = [aws_security_group.allow_web.id]
  associate_public_ip_address = true
  user_data                   = file("install_web_server.sh")
}

resource "aws_autoscaling_group" "auto_group" {
  name                      = "my_autoscaling_group-asg"
  max_size                  = 3
  min_size                  = 1
  desired_capacity          = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true
  launch_configuration      = aws_launch_configuration.web.name
  vpc_zone_identifier       = [aws_subnet.my_subnet.id]
  timeouts {
    delete = "15m"
  }
  tag {
    key                 = "Name"
    value               = "ec2_autoscaling"
    propagate_at_launch = true
  }
}


resource "aws_autoscaling_policy" "auto_policy" {
  name                   = "my_autoscaling_policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.auto_group.name
}

resource "aws_cloudwatch_metric_alarm" "cloudwatch_alarm" {
  alarm_name          = "cloudwatch_metric_alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.auto_group.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.auto_policy.arn]
}


resource "aws_autoscaling_policy" "auto_descaling" {
  name                   = "auto_descaling"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.auto_group.name
}


resource "aws_cloudwatch_metric_alarm" "descaling_cloudwatch_alarm" {
  alarm_name          = "cloudwatch_metric_alarm"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.auto_group.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.auto_policy.arn]
}
