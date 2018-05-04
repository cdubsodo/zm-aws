resource "aws_security_group_rule" "app_ingress_account_api_from_all" {
  type              = "ingress"
  from_port         = 8081
  to_port           = 8081
  protocol          = "tcp"
  source_security_group_id = "${aws_security_group.app.id}"
  security_group_id = "${local.swarm_security_group_id}"
  description       = "HTTP, Account Provisioning API"
}

resource "aws_security_group_rule" "app_ingress_https_from_all" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = "${local.swarm_security_group_id}"
  description       = "HTTPS, ZimbraX UI"
}

resource "aws_security_group_rule" "app_ingress_zimbra_core_from_all" {
  type              = "ingress"
  from_port         = 8443
  to_port           = 8443
  protocol          = "tcp"
  source_security_group_id = "${aws_security_group.app.id}"
  security_group_id = "${local.swarm_security_group_id}"
  description       = "HTTPS, Zimbra core app"
}