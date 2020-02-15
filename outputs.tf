output "ssh_to_master" {
    value = "ssh -i ${trimsuffix(var.path_to_ssh_key, ".pub")} hadoop@${aws_emr_cluster.cluster.master_public_dns}"
}

output "jupyter_port_binding" {
    value = "ssh -i ${trimsuffix(var.path_to_ssh_key, ".pub")} -NfL 8888:localhost:8888 hadoop@${aws_emr_cluster.cluster.master_public_dns}"
}

output "spark_history_binding" {
    value = "ssh -i ${trimsuffix(var.path_to_ssh_key, ".pub")} -NfL 8887:localhost:18080 hadoop@${aws_emr_cluster.cluster.master_public_dns}"
}