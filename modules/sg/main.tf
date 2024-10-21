resource "aws_security_group" "lb" {
  name        = "frontend"
  description = "Allow traffic to lb"
  vpc_id      = var.swiggy_vpc_id

  tags = {
    Name = "${var.project_name}-${var.project_environment}-lb"
  }
}
resource "aws_security_group" "backend" {
  name        = "backend"
  description = "Allow traffic to backend"
  vpc_id      = var.swiggy_vpc_id

  tags = {
    Name = "${var.project_name}-${var.project_environment}-backend"
  }
}
resource "aws_security_group" "bastion" {
  name        = "bastion"
  description = "Allow traffic to bastion"
  vpc_id      = var.swiggy_vpc_id

  tags = {
    Name = "${var.project_name}-${var.project_environment}-bastion"
  }
}

resource "aws_vpc_security_group_ingress_rule" "lb" {
  for_each          = toset(var.frontend_ports)
  security_group_id = aws_security_group.lb.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = each.key
  ip_protocol       = "tcp"
  to_port           = each.key
  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }
}
resource "aws_vpc_security_group_ingress_rule" "backend_private_http" {
  for_each                     = toset(var.backend_ports)
  security_group_id            = aws_security_group.backend.id
  referenced_security_group_id = aws_security_group.lb.id
  from_port                    = each.key
  ip_protocol                  = "tcp"
  to_port                      = each.key
  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }
}
resource "aws_vpc_security_group_ingress_rule" "backend_public_http" {
  count             = var.troubleshooting == true ? 1 : 0
  security_group_id = aws_security_group.backend.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = -1
  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }
}
resource "aws_vpc_security_group_ingress_rule" "backend_remote_http" {
  security_group_id            = aws_security_group.backend.id
  referenced_security_group_id = aws_security_group.lb.id
  from_port                    = var.ssh_port
  ip_protocol                  = "tcp"
  to_port                      = var.ssh_port
  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }
}
resource "aws_vpc_security_group_ingress_rule" "bastion_access" {
  for_each          = toset(var.bastion_ports)
  security_group_id = aws_security_group.bastion.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = each.key
  ip_protocol       = "tcp"
  to_port           = each.key
  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }
}
resource "aws_vpc_security_group_egress_rule" "frontend_ipv4" {
  security_group_id = aws_security_group.lb.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }
}
resource "aws_vpc_security_group_egress_rule" "backend_ipv4" {
  security_group_id = aws_security_group.backend.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }
}
resource "aws_vpc_security_group_egress_rule" "bastion" {
  security_group_id = aws_security_group.bastion.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }
}
resource "aws_security_group" "freedom" {
  count       = var.troubleshooting == true ? 1 : 0
  name        = "freedom"
  description = "Allow all traffic"
  vpc_id      = var.swiggy_vpc_id
  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "${var.project_name}-${var.project_environment}-freedom"
  }
}
