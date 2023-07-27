resource "aws_launch_template" "nf-launch-template" {
  name                              = "webserver-launch-template"
  #image_id                         = data.aws_ami.amzLinux.id
  image_id                          = "ami-08541bb85074a743a"
  instance_type                     = "t2.micro"
  vpc_security_group_ids            = [aws_security_group.nf_sg_http.id]
  user_data                         = filebase64("CPUstresstest.sh")
  tag_specifications {
        resource_type = "instance"
        tags          = {
            Name      = "autoserver"
   }
  }
}
resource "aws_autoscaling_group" "nf-auto-scaling-grp" {
  name                              = "nf-autoscaling-group"
  max_size                          = 4
  min_size                          = 2
  desired_capacity                  = 2
  vpc_zone_identifier               = [aws_subnet.nf_publicsubnet1.id, aws_subnet.nf_publicsubnet2.id]
  target_group_arns                 = [aws_lb_target_group.target-group.arn]
  health_check_type                 = "ELB"
  health_check_grace_period         = 300
  launch_template {
    id                = aws_launch_template.nf-launch-template.id
    version           = "$Latest"
  }
}
resource "aws_autoscaling_policy" "policy" {
  name                              = "CPUpolicy"
  policy_type                       = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type        = "ASGAverageCPUUtilization"
    }
      target_value                  = 75.0
  }
  autoscaling_group_name            = aws_autoscaling_group.nf-auto-scaling-grp.name
}