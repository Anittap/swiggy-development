resource "aws_launch_template" "backend-lt" {
  name                   = "${var.project_name}-${var.project_environment}-lt"
  image_id               = lookup(var.ami_id_map, var.region)
  instance_type          = lookup(var.instance_type, var.project_environment, "t2.micro")
  key_name               = var.key_pair
  vpc_security_group_ids = [var.sg_backend_id]
  description            = "Launch template for asg"

  tags = {
    Name        = "${var.project_name}-${var.project_environment}-webserver"
    Environment = var.project_environment
    Owner       = var.owner
    Project     = var.project_name
  }
  user_data = var.user_data
  lifecycle {
    create_before_destroy = true
  }
}
