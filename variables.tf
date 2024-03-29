
variable "vpc_id" {
    type            = string
}

variable "release_label" {
    type            = string
    default         = "emr-5.29.0"
}

variable "applications" {
    type            = list
    default         = ["Spark", "Ganglia"]
}

variable "path_to_ssh_key" {
    type            = string
    default         = "./ssh/mykey.pub"
}

variable "subnet_id" {
    type            = string
}

variable "master_instance_type" {
    type = string
    default = "m3.xlarge"
}

variable "worker_instance_type" {
    type = string
    default = "m3.xlarge"
}

variable "worker_instance_count" {
    type = string
    default = "1"
}

variable "worker_instance_ebs_size" {
    type = string
    default = "40"
}

variable "jupyter_password" {
    description     = "password for Jupyter notebook"
    type            = string
    default         = ""
}
