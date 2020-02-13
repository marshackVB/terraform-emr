# IAM Roles

data "aws_iam_policy_document" "emr_assume_role" {
    statement {
        effect           = "Allow"

        principals {
            type        = "Service"
            identifiers = ["elasticmapreduce.amazonaws.com"]
        }
    actions             = ["sts:AssumeRole"]
    }
}


data "aws_iam_policy_document" "ec2_assume_role" {
    statement {
        effect           = "Allow"

        principals {
            type         = "Service"
            identifiers  = ["ec2.amazonaws.com"]
        }

    actions              = ["sts:AssumeRole"]
    }
}


resource "aws_iam_role" "emr_service_role" {
    name                 = "emr_service_role"
    assume_role_policy   = data.aws_iam_policy_document.emr_assume_role.json
}


resource "aws_iam_role_policy_attachment" "emr_service_role" {
    role                = aws_iam_role.emr_service_role.name
    policy_arn          = "arn:aws:iam::aws:policy/service-role/AmazonElasticMapReduceRole"
}


resource "aws_iam_role" "emr_ec2_instance_profile" {
    name                = "emr_instance_profile"
    assume_role_policy  = data.aws_iam_policy_document.ec2_assume_role.json
}


resource "aws_iam_role_policy_attachment" "emr_ec2_instance_profile" {
    role                = aws_iam_role.emr_ec2_instance_profile.name
    policy_arn          = "arn:aws:iam::aws:policy/service-role/AmazonElasticMapReduceforEC2Role"
}


resource "aws_iam_instance_profile" "emr_ec2_instance_profile" {
    name                = aws_iam_role.emr_ec2_instance_profile.name
    role                = aws_iam_role.emr_ec2_instance_profile.name
}


# Security groups

locals {
    ssh_port        = 22
    any_port        = 0
    jupyter_local   = 8888
    any_protocol    = "-1"
    tcp_protocol    = "tcp"
    all_ips         = ["0.0.0.0/0"]
}

# Master
resource "aws_security_group" "emr_master" {
    vpc_id                  = var.vpc_id
    revoke_rules_on_delete  = true

}


resource "aws_security_group_rule" "allow_ssh_inbound" {
    type                = "ingress"
    security_group_id   = aws_security_group.emr_master.id
    from_port           = local.ssh_port
    to_port             = local.ssh_port
    protocol            = local.any_protocol
    cidr_blocks         = local.all_ips
}

resource "aws_security_group_rule" "allow_all_egress_master" {
    type                = "egress"
    security_group_id   = aws_security_group.emr_master.id
    from_port           = local.any_port
    to_port             = local.any_port
    protocol            = local.any_protocol
    cidr_blocks         = local.all_ips
}


# Slave
resource "aws_security_group" "emr_slave" {
    vpc_id                  = var.vpc_id
    revoke_rules_on_delete  = true
}


resource "aws_security_group_rule" "allow_all_egress_slave" {
    type                = "egress"
    security_group_id   = aws_security_group.emr_slave.id
    from_port           = local.any_port
    to_port             = local.any_port
    protocol            = local.any_protocol
    cidr_blocks         = local.all_ips
}


# Key pair
resource "aws_key_pair" "keypair" {
    key_name        = "mykey"
    public_key      = file("${var.path_to_ssh_key}")
}


# Cluster
resource "aws_emr_cluster" "cluster" {
    name                                    = "emr-test"
    release_label                           = var.release_label
    applications                            = var.applications
    termination_protection                  = false
    keep_job_flow_alive_when_no_steps       = true
    
    ec2_attributes {
        key_name                            = aws_key_pair.keypair.key_name
        subnet_id                           = var.subnet_id
        emr_managed_master_security_group   = aws_security_group.emr_master.id
        emr_managed_slave_security_group    = aws_security_group.emr_slave.id
        instance_profile                    = aws_iam_instance_profile.emr_ec2_instance_profile.arn
    }

    master_instance_group {
            name                            = "MasterInstanceGroup"
            instance_type                   = "m3.xlarge"
            instance_count                  = "1"
    }
        
    core_instance_group {
            name                            = "CoreInstanceGroup"
            instance_type                   = "m3.xlarge"
            instance_count                  = "1"
            
            ebs_config {
                size                        = "40"
                type                        = "gp2"
                volumes_per_instance        = 1
            }
    }

    service_role                            = aws_iam_role.emr_service_role.arn

}