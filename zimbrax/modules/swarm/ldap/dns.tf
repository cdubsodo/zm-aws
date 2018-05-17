resource "aws_eip" "ldap" {
  vpc = true

  tags {
    Name        = "${local.environment}_ip_ldap"
    Environment = "${local.environment}"
    Project     = "blockchain"
  }
}

resource "aws_route53_record" "ldap" {
  zone_id = "${local.r53_zone_id}"
  name    = "${local.env_prefix_d}ldap.lonni.me"
  type    = "A"
  records = ["${aws_eip.ldap.public_ip}"]
  ttl     = 60
}

resource "aws_eip_association" "ldap_eip" {
  instance_id   = "${aws_instance.ldap.id}"
  allocation_id = "${aws_eip.ldap.id}"
}
