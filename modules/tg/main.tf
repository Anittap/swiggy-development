resource "aws_lb_target_group" "backend-tg" {
  name                          = "${var.project_name}-${var.project_environment}-backend-tg"
  load_balancing_algorithm_type = "round_robin"
  port                          = 80
  protocol                      = "HTTP"
  vpc_id                        = var.vpc_id
  deregistration_delay          = 10
  health_check  {
    enabled             = true
    healthy_threshold   = 2
    interval            = 20
    path                = "/health.html"
    protocol            = "HTTP"
    unhealthy_threshold = 2
    matcher             = 200
  }
}
