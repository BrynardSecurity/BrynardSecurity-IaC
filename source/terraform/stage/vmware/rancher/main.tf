terraform {
    required_providers {
        vsphere = {
            source = "hashicorp/vsphere"
            version = ">= 2.0.2"
            configuration_aliases = [ vsphere.thebrynards ]
        }
    }
}

variable "vsphere-user" {
    description = "vSphere username"
    type = string
    sensitive = true
}

variable "vsphere-password" {
    description = "Password for vSphere user"
    type = string
    sensitive = true
}

variable "vsphere-server" {
    description = "vSphere server hostname or IP"
    type = string
    sensitive = true
}

variable "ssh-user" {
    type = string
    sensitive = true
}

variable "ssh-password" {
    type = string
    sensitive = true
}

variable "env" {
    type = string
    sensitive = true
}

variable "domain" {
    type = string
    sensitive = true
}

provider "vsphere" {
    user                 = var.vsphere-user
    password             = var.vsphere-password
    vsphere_server       = var.vsphere-server
    allow_unverified_ssl = true
}

# Create etcd nodes
module "etcd" {
    source                  = "Terraform-VMWare-Modules/vm/vsphere"
    version                 = "3.1.0"
    dc                      = "dc01.ustxa.thebrynards.com"
    vmrp                    = "BrynardSecurity Production"
    vmfolder                = "thebrynards.com"
    datastore               = "s3storage"
    vmtemp                  = "rancherOS-v1.0.0-alpha-21.10"
    instances               = 1
    cpu_number              = 2
    ram_size                = 2048
    vmname                  = "etcd"
    vmnameformat            = "%01d${var.env}"
    ipv4submask             = ["26"]
    network =  {
        "dpg-vc01-id17" = [""]
    }
    dns_server_list         = ["10.0.13.62"]
    vmgateway               = "10.0.13.62"
    tags = {
        "Environment" = "Development"
        "Cost Center" = "Home"
        "Team" = "Personal"
        "IsTerraformIAC" = "True"
    }
}

resource "null_resource" "etcd" {
    depends_on = [
        module.etcd
    ]
    connection {
        type = "ssh"
        user = "${var.ssh-user}"
        password = "${var.ssh-password}"
        host = "${element(module.etcd.ip,0)}"
    }
    provisioner "remote-exec"{
        inline = [
            "touch ~/hello_world",
            "echo 'Hello world!' > ~/hello_world"
        ]
    }
}