
variable "vpc_id" {
    type            = string
    default         = "vpc-82b24bfb"
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
    default         = "subnet-56f33d7a"
}

# Need to determine how to pass this variable to master_config.sh
variable "jupyter_password" {
    description     = "password for Jupyter notebook"
    type            = string
    default         = "mypassword"
}