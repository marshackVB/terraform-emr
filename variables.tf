
variable "vpc_id" {
    type            = string
    default         = null
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
    default         = null
}

variable "master_instance_type" {
    type = string
    default = "m3.xlarge"
}

variable "master_instance_ebs_size" {
    type = string
    default = "40"
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

variable "pip_install" {
    description = "Python packages to install on the cluster"
    type        = string
    default     = "pandas jupyter ipython jupyterlab pyspark"
}

variable "bootstrap_bucket" {
    description  = "S3 bucket containing the bootsrap scripts"
    type        = string
    default     = null
}

variable "jupyter_password" {
    description     = "password for Jupyter notebook"
    type            = string
    default         = ""
}
