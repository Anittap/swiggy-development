resource "aws_autoscaling_group" "backend" {
  name                      = "backend-asg"
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_grace_period = 100
  health_check_type         = var.enable_elb_health_checks[var.project_environment] == true ? "ELB" : "EC2"
  desired_capacity          = var.desired_size
  vpc_zone_identifier       = var.private_subnets
  launch_template {
    id      = var.lt_id
    version = var.lt_version
  }
  tag {
    key                 = "Name"
    value               = "${var.project_name}-${var.project_environment}"
    propagate_at_launch = true
  }
  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
      instance_warmup        = 90
    }
  }
}
