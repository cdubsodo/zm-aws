resource "aws_alb" "app" {
  name               = "${local.env_prefix_d}alb-app"
  subnets            = ["${local.public_subnet_ids}"]
  load_balancer_type = "application"
  
  security_groups = ["${aws_security_group.alb.id}"]

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
  
  default_action {    
    target_group_arn = "${aws_alb_target_group.zimbra_core.arn}"
    type             = "forward"  
  }
}

################################################################################## Listener rules
resource "aws_alb_listener_rule" "zimbra_core" {
  depends_on   = ["aws_alb_target_group.zimbra_core"]  
  listener_arn = "${aws_alb_listener.zimbra_core.arn}"
  action {    
    type             = "forward"    
    target_group_arn = "${aws_alb_target_group.zimbra_core.id}"  
  }   
  condition {    
    field  = "path-pattern"    
    values = ["/"]  
  }
}

################################################################################## Certificates
resource "aws_alb_listener_certificate" "zimbra_core" {
  listener_arn    = "${aws_alb_listener.zimbra_core.arn}"
  certificate_arn = "${local.app_certificate_id}"
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
    timeout             = 5    
    interval            = 30    
    path                = "/"    
    port                = 8443
    protocol            = "HTTPS"
  }
}

################################################################################## Target group endpoints (targets)
resource "aws_alb_target_group_attachment" "zimbra_core_managers" {
  target_group_arn = "${aws_alb_target_group.zimbra_core.arn}"
  
  # tested it works but just bind a manager_0
  #target_id     = "${element(local.manager_instance_ids, count.index)}" 

  #no tested yet, we need three managers nodes to be binded
  target_id = "${element(split(",", local.manager_instance_ids_string), count.index)}"
  
  port             = 8443
}