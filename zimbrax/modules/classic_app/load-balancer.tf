resource "aws_elb" "classic_app" {
  name               = "${local.env_prefix_d}classic-app"

  instances = ["${local.manager_instance_ids}"]

  cross_zone_load_balancing   = false
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  subnets = ["${local.private_subnet_ids}"]

  security_groups = ["${local.swarm_security_group_id}" ]

  listener {
    lb_port            = 80
    lb_protocol        = "http"
    instance_port      = 443
    instance_protocol  = "https"
  }

  listener {
    lb_port            = 443
    lb_protocol        = "https"
    instance_port      = 443
    instance_protocol  = "https"
    ssl_certificate_id = "${local.app_certificate_id}"
  }

  listener {
    lb_port            = 8081
    lb_protocol        = "https"
    instance_port      = 8081
    instance_protocol  = "http"
    ssl_certificate_id = "${local.app_certificate_id}"
  }

  listener {
    lb_port            = 25
    lb_protocol        = "tcp"
    instance_port      = 25
    instance_protocol  = "tcp"
  }

  listener {
    lb_port            = 587
    lb_protocol        = "tcp"
    instance_port      = 587
    instance_protocol  = "tcp"
  }

  listener {
    lb_port            = 9071
    lb_protocol        = "tcp"
    instance_port      = 9071
    instance_protocol  = "tcp"
  }

  health_check {
    healthy_threshold   = 10
    unhealthy_threshold = 2
    timeout             = 5
    target              = "HTTPS:443/"
    interval            = 30
  }

  tags {
    Name        = "${local.env_prefix_d}classic-app"
    Environment = "${local.environment}"
    Project     = "blockchain"
  }
}
