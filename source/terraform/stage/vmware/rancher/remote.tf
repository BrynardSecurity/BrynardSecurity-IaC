terraform {
  backend "remote" {
    organization = "TheBrynards"

    workspaces {
      name = "vmware-dev"
    }
  }
}