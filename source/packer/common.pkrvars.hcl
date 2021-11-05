# ----------------------------------------------------------------------------
# Name:         common.pkrvars.hcl
# Description:  Common variables for Packer builds
# Author:       Ralph Brynard
# URL:          https://github.com/RalphBrynard/terraform-rancher-cluster.git
# Date:         10/25/2021
# ----------------------------------------------------------------------------

# Boot Settings
vm_boot_wait            = "2s"
vm_boot_order           = "disk,cdrom"

# Build Settings
build_repo              = "https://github.com/RalphBrynard/terraform-rancher-cluster.git"
build_branch            = "v1.0.0-alpha"

# Packer Settings
http_port_min           = 8000
http_port_max           = 8050
http_ip                 = "10.0.10.211"
manifest_output_dir     = "./output/"