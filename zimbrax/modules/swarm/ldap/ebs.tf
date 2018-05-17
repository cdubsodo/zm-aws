resource "aws_ebs_volume" "ldap" {
    availability_zone = "${element(local.availability_zones, 0)}"
    size = 1
    type = "gp2"
    
    tags {
        Name        = "${local.environment}_ebs_ldap"
        Environment = "${local.environment}"
        Project     = "blockchain"
    }
}

resource "aws_volume_attachment" "ebs_att_ldap" {
  device_name = "/dev/sdh"
  volume_id   = "${aws_ebs_volume.ldap.id}"
  instance_id = "${aws_instance.ldap.id}"
}
