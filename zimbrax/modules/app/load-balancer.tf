resource "aws_alb" "app" {
  name               = "${local.env_prefix_d}alb-app"
  subnets            = ["${local.public_subnet_ids}"]
  load_balancer_type = "application"
  
  security_groups = ["${aws_security_group.app.id}"]

  enable_deletion_protection = true

  tags {
    Name        = "${local.environment}_alb_app"
    Environment = "${local.environment}"
    Project     = "blockchain"
  }
}

################################################################################## Listeners
resource "aws_alb_listener" "zimbra_core" {  
  load_balancer_arn = "${aws_alb.app.arn}"  
  port              = "8443"  
  protocol          = "HTTPS"
  certificate_arn   = "${local.app_certificate_id}"
  
  default_action {    
    target_group_arn = "${aws_alb_target_group.zimbra_core.arn}"
    type             = "forward"  
  }
}

resource "aws_alb_listener" "account" {  
  load_balancer_arn = "${aws_alb.app.arn}"  
  port              = "8081"  
  protocol          = "HTTPS"
  certificate_arn   = "${local.app_certificate_id}"
  
  default_action {    
    target_group_arn = "${aws_alb_target_group.account.arn}"
    type             = "forward"  
  }
}

resource "aws_alb_listener" "zm-x-web" {  
  load_balancer_arn = "${aws_alb.app.arn}"  
  port              = "443"  
  protocol          = "HTTPS"
  certificate_arn   = "${local.app_certificate_id}"
  
  default_action {    
    target_group_arn = "${aws_alb_target_group.zm-x-web.arn}"
    type             = "forward"  
  }
}

################################################################################## Listener rules
resource "aws_alb_listener_rule" "zimbra_core" {
  depends_on   = ["aws_alb_target_group.zimbra_core"]  
  listener_arn = "${aws_alb_listener.zimbra_core.arn}"
  action {    
    type             = "forward"    
    target_group_arn = "${aws_alb_target_group.zimbra_core.arn}"  
  }   
  condition {    
    field  = "path-pattern"    
    values = ["/"]  
  }
}

resource "aws_alb_listener_rule" "account" {
  depends_on   = ["aws_alb_target_group.account"]  
  listener_arn = "${aws_alb_listener.account.arn}"
  action {    
    type             = "forward"    
    target_group_arn = "${aws_alb_target_group.account.arn}"  
  }   
  condition {    
    field  = "path-pattern"    
    values = ["/"]  
  }
}

resource "aws_alb_listener_rule" "zm-x-web" {
  depends_on   = ["aws_alb_target_group.zm-x-web"]  
  listener_arn = "${aws_alb_listener.zm-x-web.arn}"
  action {    
    type             = "forward"    
    target_group_arn = "${aws_alb_target_group.zm-x-web.arn}"  
  }   
  condition {    
    field  = "path-pattern"    
    values = ["/"]  
  }
}

################################################################################## Target groups
resource "aws_alb_target_group" "zimbra_core" {  
  name     = "${local.env_prefix_d}tg-zimbra-core"
  port     = 8443
  protocol = "HTTPS"  
  vpc_id = "${local.vpc_id}"   

 
  health_check {    
    healthy_threshold   = 5    
    unhealthy_threshold = 2    
    timeout             = 10    
    interval            = 30    
    path                = "/"
    protocol            = "HTTPS"
  }
}

resource "aws_alb_target_group" "account" {  
  name     = "${local.env_prefix_d}tg-account"
  port     = 8081
  protocol = "HTTP"  
  vpc_id = "${local.vpc_id}"   

 
  health_check {    
    healthy_threshold   = 5    
    unhealthy_threshold = 2    
    timeout             = 10    
    interval            = 30    
    path                = "/"
    protocol            = "HTTP"
  }
}

resource "aws_alb_target_group" "zm-x-web" {  
  name     = "${local.env_prefix_d}tg-zm-x-web"
  port     = 443
  protocol = "HTTPS"  
  vpc_id = "${local.vpc_id}"   

 
  health_check {    
    healthy_threshold   = 5    
    unhealthy_threshold = 2    
    timeout             = 10    
    interval            = 30    
    path                = "/"
    protocol            = "HTTPS"
  }
}

################################################################################## Target group endpoints (targets)
resource "aws_autoscaling_attachment" "zimbra_core" {
  alb_target_group_arn   = "${aws_alb_target_group.zimbra_core.arn}"
  autoscaling_group_name = "${local.asg_workers_id}"
}

resource "aws_autoscaling_attachment" "account" {
  alb_target_group_arn   = "${aws_alb_target_group.account.arn}"
  autoscaling_group_name = "${local.asg_workers_id}"
}

resource "aws_autoscaling_attachment" "zm-x-web" {
  alb_target_group_arn   = "${aws_alb_target_group.zm-x-web.arn}"
  autoscaling_group_name = "${local.asg_workers_id}"
}