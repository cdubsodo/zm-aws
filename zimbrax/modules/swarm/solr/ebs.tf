resource "aws_ebs_volume" "solr" {
    count = "${local.number_of_solr_nodes}"

    availability_zone = "${element(local.availability_zones, count.index)}"
    size = 1
    type = "gp2"
    
    tags {
        Name        = "${local.environment}_ebs_solr_${count.index}"
        Environment = "${local.environment}"
        Project     = "blockchain"
    }
}

resource "aws_volume_attachment" "ebs_att_solr" {
    count = "${local.number_of_solr_nodes}"

    device_name = "/dev/sdh"
    volume_id   = "${element(aws_ebs_volume.solr.*.id, count.index)}"
    instance_id = "${element(aws_instance.solr.*.id, count.index)}"
}
