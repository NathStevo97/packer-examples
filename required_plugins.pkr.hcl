packer {
  required_plugins {
    vmware = {
      version = ">= 2.1.6"
      source  = "github.com/vmware/vmware"
    }
    qemu = {
      version = ">= 1.1.6"
      source  = "github.com/hashicorp/qemu"
    }
    # virtualbox = {
    #   version = ">= 1.1.4"
    #   source  = "github.com/hashicorp/virtualbox"
    # }
    # hyperv = {
    #   version = ">= 1.1.5"
    #   source  = "github.com/hashicorp/hyperv"
    # }
  }
}
