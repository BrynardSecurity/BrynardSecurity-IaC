# ----------------------------------------------------------------------------
# Name:         variables.auto.pkrvars.hcl
# Description:  Common vSphere variables for Photon 4 Packer builds
# Author:       Ralph Brynard (@DevopsPleb)
# URL:          https://github.com/RalphBrynard/terraform-rancher-cluster.git
# Date:         10/25/2021
# ----------------------------------------------------------------------------

# ISO Settings
os_iso_url          = "https://packages.vmware.com/photon/4.0/Rev1/iso/photon-4.0-ca7c9e933.iso"
os_iso_checksum     = "md5:d8c4bc561e68afaf7815518f78a5b4ab"

# OS Meta Data
os_family           = "Linux"
os_version          = "RancherOS"

# VM Hardware Settings
vm_firmware         = "bios"
vm_cpu_sockets      = 1
vm_cpu_cores        = 1
vm_mem_size         = 2048
vm_nic_type         = "vmxnet3"
vm_disk_controller  = ["pvscsi"]
vm_disk_size        = 16384
vm_disk_thin        = true
vm_cdrom_type       = "sata"

# VM OS Settings
vm_os_type          = "vmwarePhoton64Guest"
build_username      = "rancher"
build_password      = "rancher"

# Provisioner Settings
script_files        = [ "./scripts/rancheros-config.sh" ]
inline_cmds         = []

# Packer Settings
http_directory      = "config"
http_file           = "rancherOS.json"