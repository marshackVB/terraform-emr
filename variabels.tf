
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
    default         = ["Spark"]
}

variable "path_to_ssh_key" {
    type            = string
    default         = "./ssh/mykey.pub"
}

variable "subnet_id" {
    type            = string
    default         = "subnet-56f33d7a"
}

variable "instance_groups" {
    type            = list
    default = [
        {
            name            = "MasterInstanceGroup"
            instance_role   = "MASTER"
            instance_type   = "m3.xlarge"
            instance_count  = "1"
        },
        {
            name                            = "CoreInstanceGroup"
            instance_role                   = "CORE"
            instancetype                    = "m3.xlarge"
            instance_count                  = "1"
            ebs_root_volume_size            = "40"
            core_instance_type              = "gp2"
            volumes_per_instance            = 1
            
        
        }
    ]
}





