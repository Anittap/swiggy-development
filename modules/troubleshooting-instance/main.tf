resource "aws_instance" "troubleshooting" {
  ami                    = lookup(var.ami_id_map, var.region)
  instance_type          = lookup(var.instance_type, var.project_environment, "t2.micro")
  key_name               = var.key_pair
  vpc_security_group_ids = [var.sg_freedom_id]
  subnet_id              = var.subnet_id

  tags = {
    Name        = "${var.project_name}-${var.project_environment}-troubleshooting"
    Environment = var.project_environment
    Owner       = var.owner
    Project     = var.project_name
  }
}
