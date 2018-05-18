data "template_file" "ldap_cloud_config" {
  template = "${file("${path.module}/cloud-config/ldap-cloud-config.yaml.tpl")}"

  vars {
    ssh_authorized_keys = "ssh_authorized_keys: ${jsonencode(local.user_public_keys)}"
    environment         = "${local.environment}"
    project             = "blockchain"
    role                = "LDAP"
  }
}

data "template_file" "mounts_sh" {
  template = "${file("${path.module}/cloud-config/mounts.sh.tpl")}"

  vars {
    file_system_id = "${local.file_system_id}"
  }
}

data "template_cloudinit_config" "ldap_user_data" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/cloud-config"
    filename     = "cloud-config.yaml"
    content      = "${data.template_file.ldap_cloud_config.rendered}"
  }

  part {
    content_type = "text/x-shellscript"
    filename     = "00_mounts.sh"
    content      = "${data.template_file.mounts_sh.rendered}"
  }
}
