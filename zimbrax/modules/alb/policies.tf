resource "aws_security_group" "alb" {
  name   = "${local.env_prefix_u}alb"
  vpc_id = "${local.vpc_id}"

  tags {
    Name        = "${local.environment}_sg_alb"
    Environment = "${local.environment}"
    Project     = "blockchain"
  }
}

resource "aws_security_group_rule" "alb_ingress_for_zimbra_core_access" {
  type              = "ingress"
  from_port         = 8443
  to_port           = 8443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = "${aws_security_group.alb.id}"
  description       = "Give acces outside to the zimbra-core service (zm-docker repository)"
}

resource "aws_security_group_rule" "alb_ingress_for_account_service_access" {
  type              = "ingress"
  from_port         = 8081
  to_port           = 8081
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = "${aws_security_group.alb.id}"
  description       = "Give acces outside to the account service, this service is responsible to create Zimbra account via POST request"
}


resource "aws_security_group_rule" "alb_ingress_for_zimbra_x_web_access" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = "${aws_security_group.alb.id}"
  description       = "Give acces outside to the new UI for zimbra app (zm-x-web repository)"
}