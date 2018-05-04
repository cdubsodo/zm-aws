resource "aws_alb" "app" {
  name               = "${local.env_prefix_d}app"
  subnets            = ["${local.public_subnet_ids}"]
  load_balancer_type = "application"

  security_groups = ["${aws_security_group.app.id}"]

  enable_deletion_protection = true

  listener {
    ssl_certificate_id = "${local.app_certificate_id}"
    lb_port            = 443
    lb_protocol        = "https"
    instance_port      = 443
    instance_protocol  = "https"
  }

  listener {
    ssl_certificate_id = "${local.app_certificate_id}"
    lb_port            = 8443
    lb_protocol        = "https"
    instance_port      = 8081
    instance_protocol  = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 8
    timeout             = 30
    target              = "HTTPS:443/"
    interval            = 60
  }

  tags {
    Name        = "${local.environment}_elb_app"
    Environment = "${local.environment}"
    Project     = "blockchain"
  }
}

resource "aws_lb_listener_certificate" "https" {
  listener_arn    = "${aws_lb_listener.app.arn}"
  certificate_arn = "${local.app_certificate_id}"
}
