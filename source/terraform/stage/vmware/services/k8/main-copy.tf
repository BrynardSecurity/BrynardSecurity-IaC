provider "vsphere" {
    user                 = var.vsphere-user
    password             = var.vsphere-password
    vsphere_server       = var.vsphere-server
    allow_unverified_ssl = true
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
    default = "dev"
}

variable "domain" {
    default = "dev.ustxa.thebrynards.com"
}

data "terraform_remote_state" "vmware-dev" {
    backend = "remote"

    config = {
        organization = "TheBrynards"
        workspaces = {
            name = "vmware-dev"
        }
    }
}

module "rancher_dev" {
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
    vmname                  = "k8"
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

output "vm_ip" {
    depends_on = [
        module.rancher_dev
    ]
    value = module.rancher_dev[*].ip
}

resource "null_resource" "rancher_dev" {
    depends_on = [
        module.rancher_dev
    ]
    connection {
        type = "ssh"
        user = "${var.ssh-user}"
        password = "${var.ssh-password}"
        host = "${data.terraform_remote_state.vmware-dev.outputs.ip}"
    }
    provisioner "remote-exec"{
        inline = [
            "touch ~/hello_world",
            "echo 'Hellow world!' > ~/hello_world"
        ]
    }
}