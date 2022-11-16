resource "aws_lb" "project_loadbalancer" {
  name                       = var.loadbalancer_name
  internal                   = var.loadbalancer_internal
  load_balancer_type         = var.loadbalancer_type
  subnets                    = var.public_subnet_ids
  enable_deletion_protection = var.loadbalancer_enable_deletion_protection
}

resource "aws_lb_listener" "project_https_listener" {
  load_balancer_arn = aws_lb.project_loadbalancer.arn
  protocol          = var.loadbalancer_https_listener_protocol
  port              = var.loadbalancer_https_listener_port
  default_action {
    type             = var.loadbalancer_https_listener_default_action_type
    target_group_arn = aws_lb_target_group.project_default_target_group.arn
  }
  certificate_arn = var.acm_certificate_arn
}


resource "aws_lb_listener" "project_http_listener" {
  load_balancer_arn = aws_lb.project_loadbalancer.arn
  protocol          = var.loadbalancer_http_listener_protocol
  port              = var.loadbalancer_http_listener_port
  default_action {
    type             = var.loadbalancer_http_listener_default_action_type
    redirect {
      port        = var.loadbalancer_http_listener_default_action_redirect_port
      protocol    = var.loadbalancer_http_listener_default_action_redirect_protocol
      status_code = var.loadbalancer_http_listener_default_action_redirect_status_code
    }
  }
}

// Default target group for all unmatched traffic
resource "aws_lb_target_group" "project_default_target_group" {
  name     = var.loadbalancer_default_target_group_name
  port     = var.loadbalancer_default_target_group_port
  protocol = var.loadbalancer_default_target_group_protocol
  vpc_id   = var.vpc_id
  target_type           = var.loadbalancer_default_target_group_target_type
  health_check {
    path                = var.loadbalancer_default_target_group_health_check_path
    port                = var.loadbalancer_default_target_group_health_check_port
    healthy_threshold   = var.loadbalancer_default_target_group_health_check_healthy_threshold
    unhealthy_threshold = var.loadbalancer_default_target_group_health_check_unhealthy_threshold
    timeout             = var.loadbalancer_default_target_group_health_check_timeout
    protocol            = var.loadbalancer_default_target_group_health_check_protocol
    interval            = var.loadbalancer_default_target_group_health_check_interval
    matcher             = var.loadbalancer_default_target_group_health_check_matcher
  }
}

resource "aws_alb_listener_rule" "project_loadbalancer_listener_rule" {
  listener_arn = aws_lb_listener.project_http_listener.arn
  action {
    type = var.loadbalancer_listener_rule_action_type
    target_group_arn = aws_lb_target_group.project_default_target_group.arn
  }
  condition {
    host_header {
      values = var.loadbalancer_listener_rule_condition_host_header_values
    }
  }
}
