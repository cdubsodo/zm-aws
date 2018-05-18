resource "aws_instance" "solr" {
  count = "${local.number_of_solr_nodes}"

  ami                         = "ami-55d2af2d"
  instance_type               = "t2.2xlarge"
  key_name                    = "${local.deployer_key_pair_id}"
  subnet_id                   = "${element(local.private_subnet_ids, count.index)}"
  source_dest_check           = false
  associate_public_ip_address = false

  vpc_security_group_ids = [
    "${local.swarm_security_group_id}",
    "${local.cache_security_group_id}",
    "${local.db_security_group_id}",
    "${local.file_system_security_group_id}",
  ]
  
  root_block_device {
    volume_type = "gp2"
    volume_size = 128
  }

  user_data_base64 = "${data.template_cloudinit_config.solr_user_data.rendered}"

  tags {
    Name        = "${local.environment}_instance_solr_${count.index}"
    SwarmRole   = "SOLR"
    Environment = "${local.environment}"
    Project     = "blockchain"
  }
}
